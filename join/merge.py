from copy import copy
from pprint import pprint
import join.NameMap


def generate_sql_joins(tables, edges):
    """
    Generates SQL JOIN statements for each edge in the graph
    :param tables: A list of table information dictionaries.
    :param edges: A list of edges representing the merging order (from process_nodes).
    :return list: A list of SQL JOIN statements.
    """
    table_map = {table['table_name']: table for table in tables}

    sql_joins = []
    final_table = None
    final_select_statement = None
    name_map = join.NameMap.NameMap()

    for i in range(len(edges)):
        source_table, target_table = edges[i]  # Source and target nodes in the graph

        source_info = table_map[source_table]
        target_info = table_map[target_table]

        join_condition = []
        for fk in source_info['foreign_keys']:
            if name_map.get_name(fk['referenced_table']) == target_table:
                # pprint(fk)
                # if len(fk['columns']) == 1:
                #     source_column = fk['columns'][0]
                #     target_column = fk['referenced_columns'][0]
                #     join_condition = f"{source_table}.{source_column} = {target_table}.{target_column}"
                if len(fk['columns']) >= 1:
                    join_condition.extend(
                        [
                            f"{source_table}.{source_column} = {target_table}.{target_column}"
                            for source_column, target_column in zip(fk['columns'], fk['referenced_columns'])
                        ]
                    )
                # break
        if len(join_condition) == 0:
            e = ValueError(f"No valid foreign key relationship found between {source_table} and {target_table}")
            raise e

        join_condition = " AND ".join(join_condition)

        merged_table_name = f"{source_table}_{target_table}"
        merged_primary_keys = list(set(source_info['primary_keys'] + target_info['primary_keys']))
        merged_select_statement, merged_table_columns = generate_merge_table_columns(source_info, target_info)
        table_map[merged_table_name] = {
            'table_name': merged_table_name,
            'primary_keys': merged_primary_keys,
            'columns': merged_table_columns,
            'foreign_keys': source_info['foreign_keys'] + target_info['foreign_keys']  # Combine FKs
        }

        join_statement = (f"CREATE TABLE {merged_table_name} AS "
                          f"SELECT {merged_select_statement} FROM "
                          f"{target_table} INNER JOIN {source_table} "
                          f"ON {join_condition};")
        join_statement = join_statement.replace("`", "")
        sql_joins.append(join_statement)

        # update the table names
        name_map.add_name(source_table, merged_table_name)
        for j in range(i + 1, len(edges)):
            if edges[j][0] == source_table:
                edges[j] = (merged_table_name, edges[j][1])
            elif edges[j][1] == source_table:
                edges[j] = (edges[j][0], merged_table_name)

        final_table = merged_table_name
        final_select_statement = merged_select_statement.replace("`", "")
    # print(table_map[final_table]['columns'])
    sql_joins.append(modify_final_sql_join(sql_joins[-1], final_table, final_select_statement, table_map))
    return sql_joins, table_map[final_table]


def generate_merge_table_columns(source_info: dict, target_info: dict):
    """
    Generate the columns for the merged table
    :param source_info:
    :param target_info:
    :return select_statement, merged_table_columns:
    """

    source_columns = {column["name"] for column in source_info['columns']}  # set
    target_columns = {column["name"] for column in target_info['columns']}
    target_columns = target_columns - source_columns

    select_statement = ", ".join(
        [f"{source_info['table_name']}.{source_column}" for source_column in source_columns]
        + [f"{target_info['table_name']}.{target_column}" for target_column in target_columns]
    )

    invert_source_columns = {column['name']: column for column in source_info['columns']}
    invert_target_columns = {column['name']: column for column in target_info['columns']}

    merged_table_columns = [invert_source_columns[source_column] for source_column in source_columns] + \
                           [invert_target_columns[target_column] for target_column in target_columns]

    return select_statement, merged_table_columns

def modify_final_sql_join(final_sql_join: str, final_table:str, final_select_statement:str, table_map:dict) -> str:
    orig_final_select_statement = copy(final_select_statement)
    final_table_columns = table_map[final_table]['columns']
    # remove backticks
    for column in final_table_columns:
        column['name'] = column['name'].replace('`', '')
        column['parent'] = column['parent'].replace('`', '')
    for column in final_table_columns:
        final_select_statement = (
            final_select_statement.replace(f".{column['name']},",
                                           f".{column['name']} AS {column['parent']}_{column['name']},"))
    final_sql_join = final_sql_join.replace(orig_final_select_statement, final_select_statement)
    return final_sql_join
