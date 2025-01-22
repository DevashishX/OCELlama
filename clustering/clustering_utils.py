import networkx as nx
import matplotlib.pyplot as plt
import re
from pprint import pprint
from collections import Counter
import matplotlib.pyplot as plt
import matplotlib


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
                columns.append({"name": column_name, "definition": column_definition, "parent": table_name})

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

        # Assign Parent to a column depending on Primary key or foreign key status
        for column in columns:
            if column["name"] in primary_keys:
                column["parent"] = table_name
            else:
                for fk in foreign_keys:
                    if column["name"] in fk["columns"]:
                        column["parent"] = fk["referenced_table"]
                        break

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


def get_multidigraph(results: list) -> nx.multidigraph:
    # Create a directed graph
    graph = nx.MultiDiGraph()

    # Add nodes (tables)
    tables = [result["table_name"] for result in results]
    # graph.add_nodes_from(tables)
    for result in results:
        graph.add_node(result["table_name"], total_columns=len(result["columns"]))

    # Add Edges (the referenced table of the foreign key is the sink of the edge)
    for result in results:
        if len(result["foreign_keys"]) > 0:
            for foreign_key in result["foreign_keys"]:
                edge_weight = 1
                for referenced_column in zip(
                    foreign_key["columns"], foreign_key["referenced_columns"]
                ):
                    # graph.add_edge(result['table_name'], foreign_key['referenced_table'],
                    #                relation=referenced_column)
                    relation_key = f"{referenced_column[0]}->{referenced_column[1]}"
                    # relation_key =  referenced_column
                    graph.add_edge(
                        result["table_name"],
                        foreign_key["referenced_table"],
                        key=relation_key,
                        relation=relation_key,
                        weight=edge_weight,
                    )
                    # edge_weight += 1

    return graph


def get_simple_digraph(graph: nx.multidigraph) -> nx.digraph:
    c = Counter(graph.edges())
    simple_digraph = nx.DiGraph()
    simple_digraph.add_nodes_from(graph.nodes(data=True))

    for u, v, d in graph.edges(data=True):
        # avoid repeating edges and self-loops
        if not simple_digraph.has_edge(u, v) and u != v:
            weight = c[u, v]
            simple_digraph.add_edge(u, v, weight=weight)
            # simple_digraph.add_edge(u, v, weight=1)

    # print(list(simple_digraph.edges(data=True)))
    return simple_digraph


def get_unweighted_simple_digraph(graph: nx.multidigraph) -> nx.digraph:
    c = Counter(graph.edges())
    simple_digraph = nx.DiGraph()
    simple_digraph.add_nodes_from(graph.nodes(data=True))

    for u, v, d in graph.edges(data=True):
        # avoid repeating edges and self-loops
        if not simple_digraph.has_edge(u, v) and u != v:
            simple_digraph.add_edge(u, v)
            # simple_digraph.add_edge(u, v, weight=1)

    # print(list(simple_digraph.edges(data=True)))
    return simple_digraph


import matplotlib


def draw_colored_planar_graph(graph: nx.MultiDiGraph, communities: list):
    print(f"There are {len(communities)} communities")
    print(communities)

    fig, ax = plt.subplots(1, 1)

    fig.tight_layout()
    fig.set_size_inches(8, 8)
    node_size = 800

    if type(graph) == nx.MultiDiGraph:
        simple_digraph = get_simple_digraph(graph)
    else:
        simple_digraph = graph

    nodes = simple_digraph.nodes()

    cmap = matplotlib.colormaps["Pastel1"]  # type: matplotlib.colors.ListedColormap
    colors = cmap.colors

    # colors = ["pink", "lightgreen", "lightblue", "red", "green", "blue"]
    node_colors_dict = {}
    for entry in zip(colors[: len(communities)], communities):
        for node in entry[1]:
            node_colors_dict[node] = entry[0]
    # print(node_colors_dict)
    node_colors = [node_colors_dict[node] for node in nodes]

    pos = nx.planar_layout(simple_digraph)
    nx.draw(
        simple_digraph,
        pos,
        with_labels=True,
        node_size=node_size,
        node_color=node_colors,
        font_size=8,
        arrowsize=15,
        ax=ax,
    )
    edge_labels = nx.get_edge_attributes(simple_digraph, "weight")
    # print(type(edge_labels))
    # print(edge_labels)
    for edge in edge_labels.keys():
        edge_labels[edge] = f"{edge_labels[edge]:.2f}"

    nx.draw_networkx_edge_labels(
        simple_digraph, pos, edge_labels=edge_labels, font_size=10, ax=ax
    )
    ax.set_title("DiGraph Weighted Edges Representation")
    plt.show()


def flatten(xss):
    return [x for xs in xss for x in xs]


def draw_communities(graph: nx.DiGraph, communities):
    print(f"There are {len(communities)} communities")

    nrows = (len(communities) + 1) // 2  # Two plots per row
    fig, axs = plt.subplots(nrows, 2, squeeze=False)
    fig.tight_layout()
    fig.set_size_inches(10, 5 * nrows)
    node_size = 800

    if isinstance(graph, nx.MultiDiGraph):
        simple_digraph = nx.DiGraph(graph)  # Simplify to a directed graph
    else:
        simple_digraph = graph

    cmap = matplotlib.colormaps["Pastel1"]
    colors = cmap.colors
    colors = colors[: len(communities)]

    # Ensure axs is iterable
    axs = axs.flat
    print(colors)
    for ax, community, color in zip(axs, communities, colors):
        sub = simple_digraph.subgraph(community)
        pos = nx.planar_layout(sub)
        nx.draw(
            sub,
            pos,
            with_labels=True,
            node_size=node_size,
            node_color="lightblue",
            font_size=8,
            arrowsize=15,
            ax=ax,
        )
        edge_labels = nx.get_edge_attributes(sub, "weight")
        for edge in edge_labels.keys():
            edge_labels[edge] = f"{edge_labels[edge]:.2f}"

        nx.draw_networkx_edge_labels(
            sub, pos, edge_labels=edge_labels, font_size=10, ax=ax
        )
        ax.set_title(f"{[str(x) for x in list(community)]}")

    # Hide unused subplots
    for unused_ax in axs[len(communities) :]:
        unused_ax.axis("off")

    plt.show()


def expand_communities(graph: nx.DiGraph, communities: list):
    expanded_communities = []
    for community in communities:
        expanded = set(community)  # Start with the original community
        for node in community:
            # Add immediate neighbors the node points to
            expanded.update(graph.successors(node))
        expanded_communities.append(expanded)
    return expanded_communities
