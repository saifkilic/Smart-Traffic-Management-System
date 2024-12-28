import sys
from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from backend.graph import Graph
from backend.vehicle import VehicleManager
from backend.traffic_light import TrafficLightManager

class Backend(QObject):
    def __init__(self):
        super().__init__()
        self.graph = Graph()
        
        # Create TrafficLightManager and VehicleManager and link them
        self.traffic_lights = TrafficLightManager(None)  # Placeholder initially
        self.vehicle_manager = VehicleManager(self.traffic_lights)
        self.traffic_lights.vehicle_manager = self.vehicle_manager  # Link back to VehicleManager

    @Slot(str)
    def add_intersection(self, name):
        """Add an intersection to the graph."""
        self.graph.add_intersection(name)

    @Slot(str, str, int)
    def add_road(self, from_intersection, to_intersection, weight):
        """Add a road between two intersections."""
        self.graph.add_road(from_intersection, to_intersection, weight)


    @Slot(str, str, result=str)
    def shortest_path(self, start, end):
        """
        Find the shortest path between two intersections.
        :param start: Starting intersection
        :param end: Destination intersection
        :param is_emergency: Whether to calculate the path for emergency vehicles
        :return: Shortest path and its total distance as a string
        """
        path, distance = self.graph.shortest_path(start, end)
        if not path:
            return f"No path found from {start} to {end}."
        return f"Shortest path: {' -> '.join(path)} (Distance: {distance})"


    @Slot(str, result=str)
    def get_vehicles_at_intersection(self, intersection):
        """Get the list of vehicles at an intersection."""
        vehicles = self.vehicle_manager.get_vehicles(intersection)
        if not vehicles:
            return f"No vehicles at intersection {intersection}"
        return f"Vehicles at intersection {intersection}: {', '.join(vehicles)}"

    @Slot(str, str, bool)
    def add_vehicle(self, intersection, vehicle_type, is_emergency=False):
        self.vehicle_manager.add_vehicle(intersection, vehicle_type, is_emergency)

    @Slot(result=int)
    def get_total_vehicles(self):
        """Get the total number of vehicles across all intersections."""
        return self.vehicle_manager.total_vehicles()

    @Slot(str, result=int)
    def get_traffic_light_duration(self, intersection):
        """Get the traffic light duration for an intersection."""
        return self.traffic_lights.get_light_duration(intersection)

    @Slot(str)
    def reset_vehicle_count(self, intersection):
        """Reset the vehicle count for a specific intersection."""
        self.traffic_lights.reset_vehicle_count(intersection)

    @Slot(int)
    def set_traffic_refresh_rate(self, refresh_rate):
        """Set the frequency for updating traffic light durations."""
        self.traffic_lights.set_refresh_rate(refresh_rate)

    # Slot to listen for updates in vehicle count and update frontend
    @Slot(str, int)
    def update_vehicle_count(self, intersection, count):
        """Update the vehicle count for an intersection in the frontend."""
        self.traffic_lights.vehicle_count_updated.emit(intersection, count)


def main():
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    backend = Backend()
    engine.rootContext().setContextProperty("backend", backend)

    engine.load("design/main.qml")
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())

if __name__ == "__main__":
    main()