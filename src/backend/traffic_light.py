import heapq
from collections import defaultdict
from PySide6.QtCore import QObject, QTimer, Slot


class TrafficLightManager(QObject):
    def __init__(self, vehicle_manager, refresh_rate=1000):
        super().__init__()
        self.vehicle_manager = vehicle_manager
        self.light_queue = []  # Priority queue (max-heap via negative vehicle density)
        self.light_durations = defaultdict(lambda: 10)  # Default 10 seconds per light
        self.refresh_rate = refresh_rate

        # Timer for updating traffic lights
        self.timer = QTimer()
        self.timer.timeout.connect(self.update_traffic_lights)
        self.timer.start(self.refresh_rate)

    def update_light_queue(self):
        """Refresh the light priority queue using vehicle densities."""
        heapq.heapify(self.light_queue)
        for intersection, vehicles in self.vehicle_manager.vehicle_data.items():
            density = len(vehicles)
            heapq.heappush(self.light_queue, (-density, intersection))  # -density makes it max-heap

    def update_traffic_lights(self):
        """Update light durations for intersections based on vehicle densities."""
        self.update_light_queue()
        while self.light_queue:
            density, intersection = heapq.heappop(self.light_queue)
            duration = max(10, -density * 2)  # Base 10s + 2s per vehicle
            self.light_durations[intersection] = duration

    @Slot(str, result=int)
    def get_light_duration(self, intersection):
        """Expose current light duration for an intersection."""
        return self.light_durations.get(intersection, 10)

    @Slot(int)
    def set_refresh_rate(self, refresh_rate):
        """Set the frequency for light updates."""
        self.refresh_rate = refresh_rate
        self.timer.setInterval(refresh_rate)
