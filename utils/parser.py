import re

def parse_ddl(ddl: str):
    """
    Parses SQL DDL statements and extracts table names, columns, primary keys, and foreign keys.

    :param ddl: DDL string containing table definitions.
    :return: A list of dictionaries with keys: table_name, columns, primary_keys, foreign_keys.
    """
    tables_info = []

    # Split the DDL into individual CREATE TABLE statements
    table_statements = re.split(r"CREATE TABLE", ddl, flags=re.IGNORECASE)[1:]

    for statement in table_statements:
        # Extract table name
        table_name_match = re.search(r"`(\w+)`", statement)
        if not table_name_match:
            continue
        table_name = table_name_match.group(0)  # Include backticks in table name

        # Remove the CREATE TABLE `tablename` part from the statement
        statement = re.sub(r"^\s*`\w+`\s*\(", "", statement, count=1)

        # Split statement into lines and filter out non-column definitions
        lines = statement.splitlines()
        column_lines = []
        for line in lines:
            line = line.strip()
            if (
                line.startswith("PRIMARY KEY")
                or line.startswith("KEY")
                or line.startswith("CONSTRAINT")
                or line.startswith("FOREIGN KEY")
            ):
                continue
            if line.endswith(","):
                line = line[:-1]
            column_lines.append(line)

        # Extract column definitions
        column_pattern = r"(`\w+`)\s+([^,]+)"
        columns = []
        for column_line in column_lines:
            column_match = re.match(column_pattern, column_line)
            if column_match:
                column_name = column_match.group(1)  # Include backticks in column name
                column_definition = column_match.group(2).strip()
                columns.append({"name": column_name, "definition": column_definition})

        # Extract primary key
        primary_key_match = re.search(r"PRIMARY KEY \(([`\w`, ]+)\)", statement)
        primary_keys = (
            [key.strip() for key in primary_key_match.group(1).split(",")]
            if primary_key_match
            else []
        )

        # Extract foreign keys
        fk_pattern = r"FOREIGN KEY \(([`\w`, ]+)\) REFERENCES ([`\w`]+) \(([`\w`, ]+)\)(?: ON DELETE (\w+))?"
        foreign_keys = []
        for fk_match in re.findall(fk_pattern, statement):
            from_columns = [col.strip() for col in fk_match[0].split(",")]
            referenced_table = fk_match[1]
            referenced_columns = [col.strip() for col in fk_match[2].split(",")]
            on_delete = fk_match[3] if fk_match[3] else "NO ACTION"

            foreign_keys.append(
                {
                    "columns": from_columns,
                    "referenced_table": referenced_table,
                    "referenced_columns": referenced_columns,
                    "on_delete": on_delete,
                }
            )

        # Store table information
        tables_info.append(
            {
                "table_name": table_name,
                "columns": columns,
                "primary_keys": primary_keys,
                "foreign_keys": foreign_keys,
            }
        )

    return tables_info