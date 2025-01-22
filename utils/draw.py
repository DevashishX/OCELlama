import networkx as nx
import matplotlib.pyplot as plt
import matplotlib
import utils.graphutils


def draw_planar_graph(graph: nx.MultiDiGraph):
    fig, ax = plt.subplots(1, 1)

    fig.tight_layout()
    fig.set_size_inches(8, 8)
    node_size = 800

    if type(graph) == nx.MultiDiGraph:
        c = Counter(graph.edges())
        simple_digraph = nx.DiGraph()
        simple_digraph.add_nodes_from(graph)

        for u, v, d in graph.edges(data=True):
            # avoid repeating edges and self-loops
            if not simple_digraph.has_edge(u, v) and u != v:
                simple_digraph.add_edge(u, v, weight=c[u, v])
    else:
        simple_digraph = graph

    pos = nx.planar_layout(simple_digraph)
    nx.draw(simple_digraph, pos, with_labels=True, node_size=node_size,
            node_color="lightblue", font_size=8,
            arrowsize=15,
            ax=ax)
    edge_labels = nx.get_edge_attributes(simple_digraph, "weight")

    nx.draw_networkx_edge_labels(simple_digraph, pos,
                                 edge_labels=edge_labels, font_size=10, ax=ax)
    ax.set_title("DiGraph Weighted Edges Representation")
    plt.show()

def draw_colored_planar_graph(graph: nx.MultiDiGraph, communities: list):
    print(f"There are {len(communities)} communities")
    print(communities)

    fig, ax = plt.subplots(1, 1)

    fig.tight_layout()
    fig.set_size_inches(8, 8)
    node_size = 800

    if type(graph) == nx.MultiDiGraph:
        simple_digraph = graphutils.get_simple_digraph(graph)
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
    for unused_ax in axs[len(communities):]:
        unused_ax.axis("off")

    plt.show()
