import sys
from PySide6.QtCore import QObject, Slot
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from backend.graph import Graph
from backend.vehicle import VehicleManager

class Backend(QObject):
    def __init__(self):
        super().__init__()
        self.graph = Graph()
        self.vehicle_manager = VehicleManager()

    @Slot(str)
    def add_intersection(self, name):
        """Add an intersection node to the graph."""
        self.graph.add_intersection(name)

    @Slot(str, str, int)
    def add_road(self, from_intersection, to_intersection, weight):
        """Add a road (edge) between intersections."""
        self.graph.add_road(from_intersection, to_intersection, weight)

    @Slot(str, str, result=str)
    def find_shortest_path(self, start, end):
        """Find the shortest path between two intersections."""
        distance = self.graph.shortest_path(start, end)
        if distance == float('inf'):
            return f"No path found between {start} and {end}"
        return f"Shortest path from {start} to {end}: {distance}"

    @Slot(str, str)
    def add_vehicle(self, intersection, vehicle_type):
        """Add a vehicle (e.g., car, ambulance) at an intersection."""
        self.vehicle_manager.add_vehicle(intersection, vehicle_type)

    @Slot(str, result=str)
    def get_vehicles_at_intersection(self, intersection):
        """Get the list of vehicles at a specific intersection."""
        vehicles = self.vehicle_manager.get_vehicles(intersection)
        if not vehicles:
            return f"No vehicles at intersection {intersection}"
        return f"Vehicles at intersection {intersection}: {', '.join(vehicles)}"

    @Slot(result=int)
    def get_total_vehicles(self):
        """Get the total count of vehicles across all intersections."""
        return self.vehicle_manager.total_vehicles()

def main():
    """Main function to run the PyQt application and connect backend to QML."""
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    backend = Backend()
    engine.rootContext().setContextProperty("backend", backend)
    
    engine.load("design/main.qml")  # QML file path for frontend
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())

if __name__ == "__main__":
    main()
