import networkx as nx

def dummy_sequence():
    print("dummy")
    pass

class Sequencer():
    def __init__(self, graph: nx.Graph, coms: list, ext_coms: list):
        self.graph = graph
        self.coms = coms
        self.ext_coms = ext_coms
        self.sequences = None
        pass

    def get_sequences(self):
        if self.sequences is None:
            print("Sequence not yet generated")
        return self.sequences

    def create_sequences(self, strategy:str = "default"):
        if strategy == "default":
            self.sequences = self.default_sequences()
        else:
            self.sequences = self.default_sequences()

    def default_sequences(self):
        sequences = []
        for community in self.ext_coms:
            sequences.append(nx.maximum_spanning_tree(self.graph.subgraph(community)))
        return sequences