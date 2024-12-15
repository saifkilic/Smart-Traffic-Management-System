class VehicleManager:
    def __init__(self, traffic_light_manager):
        self.vehicle_data = {}  # Store vehicles: {intersection: [vehicles]}
        self.traffic_light_manager = traffic_light_manager

    def add_vehicle(self, intersection, vehicle_type, is_emergency=False):
        """Add a vehicle to a specific intersection."""
        if intersection not in self.vehicle_data:
            self.vehicle_data[intersection] = []
        self.vehicle_data[intersection].append(vehicle_type)

        # Update vehicle count in TrafficLightManager
        self.traffic_light_manager.increment_vehicle_count(intersection, is_emergency)

    def remove_vehicle(self, intersection):
        """Remove a vehicle from a specific intersection."""
        if intersection in self.vehicle_data and self.vehicle_data[intersection]:
            self.vehicle_data[intersection].pop()
            self.traffic_light_manager.decrement_vehicle_count(intersection)

    def get_vehicles(self, intersection):
        """Get all vehicles at a specific intersection."""
        return self.vehicle_data.get(intersection, [])

    def total_vehicles(self):
        """Get the total count of vehicles across all intersections."""
        return sum(len(vehicles) for vehicles in self.vehicle_data.values())
