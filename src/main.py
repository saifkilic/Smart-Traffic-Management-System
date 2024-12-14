import sys
from PySide6.QtCore import QObject, Slot
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from backend.graph import Graph
from backend.vehicle import VehicleManager
from backend.traffic_light import TrafficLightManager


class Backend(QObject):
    def __init__(self):
        super().__init__()
        self.graph = Graph()
        self.vehicle_manager = VehicleManager()
        self.traffic_lights = TrafficLightManager(self.vehicle_manager)

    @Slot(str)
    def add_intersection(self, name):
        self.graph.add_intersection(name)

    @Slot(str, str, int)
    def add_road(self, from_intersection, to_intersection, weight):
        self.graph.add_road(from_intersection, to_intersection, weight)

    @Slot(str, str, result=str)
    def find_shortest_path(self, start, end):
        distance = self.graph.shortest_path(start, end)
        if distance == float('inf'):
            return f"No path found between {start} and {end}"
        return f"Shortest path from {start} to {end}: {distance}"

    @Slot(str, str)
    def add_vehicle(self, intersection, vehicle_type):
        self.vehicle_manager.add_vehicle(intersection, vehicle_type)

    @Slot(str, result=str)
    def get_vehicles_at_intersection(self, intersection):
        vehicles = self.vehicle_manager.get_vehicles(intersection)
        if not vehicles:
            return f"No vehicles at intersection {intersection}"
        return f"Vehicles at intersection {intersection}: {', '.join(vehicles)}"

    @Slot(result=int)
    def get_total_vehicles(self):
        return self.vehicle_manager.total_vehicles()

    @Slot(str, result=int)
    def get_traffic_light_duration(self, intersection):
        return self.traffic_lights.get_light_duration(intersection)

    @Slot(int)
    def set_traffic_refresh_rate(self, refresh_rate):
        self.traffic_lights.set_refresh_rate(refresh_rate)


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
