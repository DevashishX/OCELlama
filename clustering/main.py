import clustering_utils, analyser


def main():
    DDL_file = "test_parser.sql"
    with open(DDL_file) as fp:
        ddl = fp.read()
    results = clustering_utils.parse_ddl(ddl)
    print(f"#Tables: {len(results)}")
    graph = clustering_utils.get_multidigraph(results)
    simple_graph = clustering_utils.get_unweighted_simple_digraph(graph)
    graph_analyser = analyser.Analyser(simple_graph)
    df = graph_analyser.analyse_communities()
    print(df)
    print(graph_analyser.best_community["communities"])
    print(type(simple_graph))
    expanded_graph = clustering_utils.expand_communities(
        simple_graph, graph_analyser.best_community["communities"]
    )
    print(expanded_graph)


if __name__ == "__main__":
    main()
