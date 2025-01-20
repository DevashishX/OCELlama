from typing import List
import networkx as nx
from cdlib import algorithms
import math
import itertools


class Cluster:

    def __init__(self, graph: nx.Graph):
        if graph is not None and isinstance(graph, nx.Graph):
            self.graph = graph.to_undirected()
        else:
            raise TypeError(f"Passed Graph:{str(graph)} is not of type nx.Graph")
        self.n_communities = math.floor(math.sqrt(self.graph.number_of_nodes()))
        self._cluster_methods = [
            # self._conga,
            self._girvan_newman,
            self._edge_current_flow,
            self._greedy_modularity_communities,
            self._asyn_lpa_communities,
            self._label_propogation_communities,
            self._fast_label_propagation_communities,
            self._asyn_fluidc,
        ]

    def create_communities(self, n_communities: int = None) -> list:
        if n_communities is None:
            self.n_communities = math.floor(math.sqrt(self.graph.number_of_nodes()))
        else:
            self.n_communities = n_communities
        result_list = []
        for cluster_method in self._cluster_methods:
            result = cluster_method()
            if result is not None:
                result_list.append(result)
        return result_list

    def _girvan_newman(self):
        name = "girvan_newman"
        coms = nx.community.girvan_newman(self.graph)
        limited = list(
            itertools.takewhile(lambda c: len(c) <= self.n_communities, coms)
        )
        if len(limited) > 0:
            print(limited)
            communities = limited[-1]
            return self.__info_tuple(name, communities)
        else:
            return None

    def _edge_current_flow(self):
        name = "edge_current_flow_betweenness_partition"
        coms = nx.community.edge_current_flow_betweenness_partition(
            self.graph, self.n_communities
        )
        return self.__info_tuple(name, coms)

    def _greedy_modularity_communities(self):
        name = "greedy_modularity_communities"
        coms = nx.community.greedy_modularity_communities(self.graph)
        return self.__info_tuple(name, coms)

    def _asyn_lpa_communities(self):
        name = "asyn_lpa_communities"
        coms = nx.community.asyn_lpa_communities(self.graph, seed=0)
        return self.__info_tuple(name, coms)

    def _label_propogation_communities(self):
        name = "label_propogation_communities"
        coms = nx.community.label_propagation_communities(self.graph)
        return self.__info_tuple(name, coms)

    def _fast_label_propagation_communities(self):
        name = "fast_label_propagation_communities"
        coms = nx.community.fast_label_propagation_communities(self.graph, seed=0)
        return self.__info_tuple(name, coms)

    def _louvain_communities(self):
        name = "louvain_communities"
        coms = nx.community.louvain_communities(self.graph, seed=0)
        return self.__info_tuple(name, coms)

    def _asyn_fluidc(self):
        name = "asyn_fluidc"
        coms = nx.community.asyn_fluidc(self.graph, self.n_communities, seed=0)
        return self.__info_tuple(name, coms)

    def _conga(self):  # excluded
        name = "conga"
        communities = algorithms.conga(self.graph, self.n_communities).communities
        return self.__info_tuple(name, communities)

    def __info_tuple(self, name: str, communities: List):
        communities = list(communities)
        return {
            "algorithm": name,
            "n_communities": len(communities),
            "communities": communities,
        }
