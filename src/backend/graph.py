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

    def get_neighbors(self, node):
        """Return the neighbors and weights of a given node."""
        return self.edges.get(node, [])

    def shortest_path(self, start, end):
        """
        Calculate the shortest path using Dijkstra's algorithm.
        :param start: Starting intersection
        :param end: Destination intersection
        :return: Tuple containing the shortest path as a list and its total distance
        """
        queue = [(0, start)]  # Priority Queue (distance, node)
        distances = {node: float('inf') for node in self.nodes}
        distances[start] = 0
        previous_nodes = {node: None for node in self.nodes}  # To reconstruct the path

        while queue:
            current_distance, current_node = heapq.heappop(queue)

            # If the node is the destination, reconstruct the path and return it
            if current_node == end:
                return self.reconstruct_path(previous_nodes, start, end), current_distance

            # Explore neighbors (connected intersections)
            for neighbor, weight in self.get_neighbors(current_node):
                distance = current_distance + weight
                if distance < distances[neighbor]:
                    distances[neighbor] = distance
                    previous_nodes[neighbor] = current_node
                    heapq.heappush(queue, (distance, neighbor))

        return [], float('inf')  # Return empty path and infinity if no path is found

    def reconstruct_path(self, previous_nodes, start, end):
        """Reconstruct the path from start to end."""
        path = []
        current = end
        while current is not None:
            path.append(current)
            current = previous_nodes[current]
        path.reverse()
        return path

    def calculate_traffic_priority(self, densities):
        """
        Adjust traffic light durations based on real-time vehicle densities.
        :param densities: Dictionary with intersections as keys and vehicle densities as values.
        :return: Priority queue with intersections and adjusted durations.
        """
        priority_queue = []
        for intersection, density in densities.items():
            duration = max(10, min(120, int(120 / (1 + density))))  # Duration between 10 and 120 seconds
            heapq.heappush(priority_queue, (density, intersection, duration))
        return priority_queue
