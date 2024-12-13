class Graph:
    def __init__(self):
        self.nodes = set()  # Set of intersections (nodes)
        self.edges = {}  # Dictionary for adjacency list: {node: [(neighbor, weight)]}

    def add_node(self, node):
        """Add a new intersection (node) to the graph."""
        self.nodes.add(node)
        self.edges[node] = []

    def add_edge(self, from_node, to_node, weight):
        """Add a road (edge) between two intersections."""
        if from_node not in self.edges:
            self.edges[from_node] = []
        if to_node not in self.edges:
            self.edges[to_node] = []

        self.edges[from_node].append((to_node, weight))
        self.edges[to_node].append((from_node, weight))  # Undirected graph

    def shortest_path(self, start, end):
        """Calculate the shortest path using Dijkstra's algorithm."""
        import heapq

        # Priority queue to store (distance, node)
        queue = [(0, start)]
        distances = {node: float('inf') for node in self.nodes}
        distances[start] = 0

        while queue:
            current_distance, current_node = heapq.heappop(queue)

            # Stop if we've reached the destination
            if current_node == end:
                return current_distance

            for neighbor, weight in self.edges[current_node]:
                distance = current_distance + weight
                if distance < distances[neighbor]:
                    distances[neighbor] = distance
                    heapq.heappush(queue, (distance, neighbor))

        return float('inf')  # Return infinity if no path is found
