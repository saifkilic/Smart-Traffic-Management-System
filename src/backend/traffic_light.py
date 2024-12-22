import heapq
from collections import defaultdict
from PySide6.QtCore import QObject, QTimer, Slot, Signal
import logging

logging.basicConfig(level=logging.DEBUG)


class TrafficLightManager(QObject):
    # Signal to communicate updates
    vehicle_count_updated = Signal(str, int)

    def __init__(self, vehicle_manager, refresh_rate=1000):
        super().__init__()
        self.vehicle_manager = vehicle_manager
        self.refresh_rate = refresh_rate

        self.vehicle_counters = defaultdict(int)  # Vehicle counters per intersection
        self.light_durations = defaultdict(lambda: 10)  # Default duration is 10 seconds
        self.emergency_vehicle_count = defaultdict(int)  # Emergency vehicle counters
        self.light_queue = []  # Priority queue for intersections

        # Timer for updating traffic lights
        self.timer = QTimer()
        self.timer.timeout.connect(self.update_traffic_lights)
        self.timer.start(self.refresh_rate)

    def update_traffic_lights(self):
        """Update light durations dynamically based on vehicle density and emergencies."""
        self.refresh_priority_queue()

        while self.light_queue:
            _, intersection = heapq.heappop(self.light_queue)
            vehicle_count = self.vehicle_counters[intersection]
            emergency_count = self.emergency_vehicle_count[intersection]

            # Calculate duration with priority for emergencies
            base_duration = max(10, vehicle_count * 5)  # 5 seconds per vehicle
            emergency_bonus = 10 * emergency_count  # Extra time for emergencies
            self.light_durations[intersection] = min(120, base_duration + emergency_bonus)

            # Logging traffic light updates
            logging.debug(
                f"Updated: {intersection}, Vehicles: {vehicle_count}, Emergencies: {emergency_count}, Duration: {self.light_durations[intersection]}"
            )

    def refresh_priority_queue(self):
        """Refresh the priority queue based on vehicle and emergency density."""
        self.light_queue = []
        for intersection, vehicle_count in self.vehicle_counters.items():
            # Emergency vehicles have higher priority, adjusting weights for the queue
            emergency_count = self.emergency_vehicle_count[intersection]
            priority = -(vehicle_count + 5 * emergency_count)  # Higher priority for emergencies
            heapq.heappush(self.light_queue, (priority, intersection))

    @Slot(str)
    def increment_vehicle_count(self, intersection, is_emergency=False):
        """Increment the vehicle counter and optionally flag it as emergency."""
        self.vehicle_counters[intersection] += 1
        if is_emergency:
            self.emergency_vehicle_count[intersection] += 1

        # Logging vehicle count changes
        logging.debug(
            f"Incremented vehicle count at {intersection}: Total: {self.vehicle_counters[intersection]}, Emergencies: {self.emergency_vehicle_count[intersection]}"
        )
        self.refresh_priority_queue()

    @Slot(str)
    def decrement_vehicle_count(self, intersection):
        """Decrement the vehicle counter when a vehicle departs."""
        if self.vehicle_counters[intersection] > 0:
            self.vehicle_counters[intersection] -= 1
        logging.debug(f"Decremented vehicle count at {intersection}: {self.vehicle_counters[intersection]}")

    @Slot(str)
    def reset_vehicle_count(self, intersection):
        """Reset the vehicle counters for a specific intersection."""
        self.vehicle_counters[intersection] = 0
        self.emergency_vehicle_count[intersection] = 0
        self.light_durations[intersection] = 10
        logging.debug(f"Reset vehicle count at {intersection}")

    @Slot(str, result=int)
    def get_light_duration(self, intersection):
        """Get the current traffic light duration for an intersection."""
        return self.light_durations.get(intersection, 10)

    @Slot(int)
    def set_refresh_rate(self, refresh_rate):
        """Set the frequency for updating traffic light durations."""
        self.refresh_rate = refresh_rate
        self.timer.setInterval(refresh_rate)
        logging.debug(f"Refresh rate set to: {refresh_rate}ms")
