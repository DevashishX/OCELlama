import networkx as nx

from clustering import clustering_utils

ddl_file = "clustering\\university2_structure.sql"


def get_graph():
    with open(ddl_file) as fp:
        ddl = fp.read()
    results = clustering_utils.parse_ddl(ddl)
    print(f"#Tables: {len(results)}")
    graph = clustering_utils.get_multidigraph(results)
    simple_graph = clustering_utils.get_unweighted_simple_digraph(graph)
    return simple_graph


def get_communities():
    communities = [{'`student`', '`department`', '`advisor`', '`instructor`'},
                   {'`section`', '`time_slot`', '`classroom`', '`takes`', '`teaches`'}, {'`prereq`', '`course`'}]
    return communities


def get_extended_communities():
    extended_communities = [{'`student`', '`department`', '`advisor`', '`instructor`'},
                            {'`time_slot`', '`classroom`', '`takes`', '`student`', '`teaches`', '`section`', '`course`',
                             '`instructor`'}, {'`prereq`', '`department`', '`course`'}]
    return extended_communities


def get_parsed_data():
    with open(ddl_file) as fp:
        ddl = fp.read()
    results = clustering_utils.parse_ddl(ddl)
    return results
