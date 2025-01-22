import networkx as nx
import re

def duplicate(graph: nx.DiGraph):
    def duplicate_node(graph, node):
        in_edges = list(graph.in_edges(node, data=True))
        if len(in_edges) <= 1:
            return

        for i, (src, _, attr) in enumerate(in_edges[:-1], start=1):
            new_node = f"{node}_dup_{i}"
            graph.add_node(new_node, **graph.nodes[node])

            graph.add_edge(src, new_node, **attr)

            for _, tgt, out_attr in graph.out_edges(node, data=True):
                graph.add_edge(new_node, tgt, **out_attr)

            graph.remove_edge(src, node)

    copy_graph = graph.copy()

    while True:
        nodes_to_duplicate = [node for node in graph.nodes if copy_graph.in_degree(node) > 1]
        if not nodes_to_duplicate:
            break
        for node in nodes_to_duplicate:
            duplicate_node(copy_graph, node)
    new_graph_components = nx.weakly_connected_components(copy_graph)
    new_graphs = [copy_graph.subgraph(new_graph_component).copy() for new_graph_component in new_graph_components]
    # for i in range(len(new_graphs)):
    #     new_graphs[i] = rename_duplicated_nodes(new_graphs[i])
    return new_graphs


def rename_duplicated_nodes(graph):
    mapping = {}
    for node in graph.nodes:
        match = re.match(r"^(.*)_dup_\d+$", str(node))
        if match:
            original_node = match.group(1)
            mapping[node] = original_node
    return nx.relabel_nodes(graph, mapping, copy=True)
