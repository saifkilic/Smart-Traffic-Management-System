import heapq

class Graph:
    def __init__(self):
        self.nodes = set()  # Intersections (nodes)
        self.edges = {}  # Roads (edges) with weights

    def add_intersection(self, intersection):
        """Add an intersection (node) to the graph."""
        self.nodes.add(intersection)
        if intersection not in self.edges:
            self.edges[intersection] = []

    def add_road(self, from_intersection, to_intersection, weight):
        """Add a road (edge) between two intersections with a specified weight."""
        if from_intersection not in self.edges:
            self.edges[from_intersection] = []
        if to_intersection not in self.edges:
            self.edges[to_intersection] = []
        self.edges[from_intersection].append((to_intersection, weight))

    def shortest_path(self, start, end, emergency=False):
        """Calculate the shortest path using Dijkstra's algorithm, with consideration for emergency vehicles."""
        queue = [(0, start)]  # Priority Queue (distance, node)
        distances = {node: float('inf') for node in self.nodes}
        distances[start] = 0

        while queue:
            current_distance, current_node = heapq.heappop(queue)

            # If the node is the destination, return the shortest distance
            if current_node == end:
                return current_distance

            # Explore neighbors (connected intersections)
            for neighbor, weight in self.edges[current_node]:
                if emergency:
                    weight = weight * 0.5  # Reduce weight by 50% for emergency vehicles (quicker route)
                
                distance = current_distance + weight
                if distance < distances[neighbor]:
                    distances[neighbor] = distance
                    heapq.heappush(queue, (distance, neighbor))

        return float('inf')  # Return infinity if no path is found
