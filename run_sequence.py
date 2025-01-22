from clustering import dummy
import sequence.duplication

def main():
    graph = dummy.get_graph()
    # graph_undirected = graph.to_undirected()
    coms = dummy.get_communities()[1]
    ext_coms = dummy.get_extended_communities()[1]
    print("coms", coms, "ext_coms", ext_coms, sep="\n")
    ext_sub_graph = sequence.duplication.duplicate_nodes_with_multiple_in_edges(graph.subgraph(ext_coms))
    print(ext_sub_graph.edges())

    return

if __name__ == "__main__":
    main()
