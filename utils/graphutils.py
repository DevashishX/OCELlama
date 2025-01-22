import networkx as nx
import matplotlib.pyplot as plt
import re
from pprint import pprint
from collections import Counter


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


def flatten(xss):
    return [x for xs in xss for x in xs]

# DDL_file = "./test_parser.sql"
# with open(DDL_file) as fp:
#     ddl = fp.read()
# results = parse_ddl(ddl)
# print(f"#Tables: {len(results)}")
# # pprint(results)
# graph = get_multidigraph(results)
# simple_graph = get_simple_digraph(graph)
#
# print("MultiDiGraph Edges: ", graph.edges(data=True))
# print("DiGraph Edges: ", simple_graph.edges(data=True))
#
# # simple_graph = simple_graph.subgraph(simple_graph.nodes() - ["`time_slot`", "`classroom`"])
# communities = nx.community.louvain_communities(simple_graph, seed=0)
# print(f"Louvain Communities: {list(communities)}")
# # draw_colored_planar_graph(simple_graph, communities)
# # draw_communities(simple_graph, list(communities))
