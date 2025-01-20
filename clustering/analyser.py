import networkx as nx
import cdlib as cd
import cluster
import pandas as pd


class Analyser:
    def __init__(self, graph: nx.Graph, name: str = None):
        if graph is not None and isinstance(graph, nx.Graph):
            self.graph = graph.to_undirected()
        else:
            raise TypeError(f"Passed Graph:{str(graph)} is not of type nx.Graph")
        if name is None:
            self.name = str(self.graph)
        else:
            self.name = name

    def analyse_communities(self):
        self._cluster = cluster.Cluster(self.graph)
        self.communities = pd.DataFrame(self._cluster.create_communities())
        self.communities["modularity"] = self.communities["communities"].map(
            self.modularity
        )
        self.best_community = self.communities.iloc[
            self.communities["modularity"].idxmax()
        ]
        return self.communities

    def modularity(self, communities: pd.Series):
        return nx.community.modularity(self.graph, communities)

    pass
