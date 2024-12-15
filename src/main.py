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
        self.traffic_lights = TrafficLightManager(None)  # Placeholder for VehicleManager
        self.vehicle_manager = VehicleManager(self.traffic_lights)
        self.traffic_lights.vehicle_manager = self.vehicle_manager  # Link back to VehicleManager

    @Slot(str)
    def add_intersection(self, name):
        self.graph.add_intersection(name)

    @Slot(str, str, int)
    def add_road(self, from_intersection, to_intersection, weight):
        self.graph.add_road(from_intersection, to_intersection, weight)

    @Slot(str, str, bool)
    def add_vehicle(self, intersection, vehicle_type, is_emergency=False):
        self.vehicle_manager.add_vehicle(intersection, vehicle_type, is_emergency)

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

    @Slot(str)
    def reset_vehicle_count(self, intersection):
        self.traffic_lights.reset_vehicle_count(intersection)

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
