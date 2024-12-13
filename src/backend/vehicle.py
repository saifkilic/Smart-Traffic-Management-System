class VehicleManager:
    def __init__(self):
        self.vehicle_data = {}  # Store vehicles: {intersection: [vehicles]}

    def add_vehicle(self, intersection, vehicle_type):
        """Add a vehicle to a specific intersection."""
        if intersection not in self.vehicle_data:
            self.vehicle_data[intersection] = []
        self.vehicle_data[intersection].append(vehicle_type)

    def get_vehicles(self, intersection):
        """Get all vehicles at a specific intersection."""
        return self.vehicle_data.get(intersection, [])

    def total_vehicles(self):
        """Get total count of vehicles across all intersections."""
        return sum(len(v) for v in self.vehicle_data.values())
