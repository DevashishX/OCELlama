import networkx as nx
import re

def process_dag(digraph: nx.DiGraph):
    graph = digraph.copy()
    edge_queue = []
    while graph.nodes:
        min_out_degree = min([graph.out_degree(node) for node in graph.nodes])
        nodes_to_process = [node for node in graph.nodes if graph.out_degree(node) == min_out_degree]

        for node in nodes_to_process:
            for predecessor in graph.predecessors(node):
                edge_queue.append((predecessor, node))

            graph.remove_node(node)

    return edge_queue

def rename_duplicated_nodes(queue):
    mapping = {}
    for edge in queue:
        for node in edge:
            match = re.match(r"^(.*)_dup_\d+$", str(node))
            if match:
                original_node = match.group(1)
                mapping[node] = original_node
    for i in range(len(queue)):
        queue[i] = tuple(mapping.get(node, node) for node in queue[i])
    return queue