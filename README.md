# Smart Traffic Management System

## Overview

The **Smart Traffic Management System** is designed to optimize traffic flow and ensure efficient management of roads and intersections within a city. It simulates the operation of a road network, where each intersection is modeled as a node in a graph, and each road between intersections as edges in the graph. The system uses Dijkstra's Shortest Path Algorithm and Priority Queues to manage vehicles and optimize traffic flow.

---
## Features
### Graph Construction & Representation: 
Dynamic addition of intersections and roads.
### Shortest Path Calculation (Dijkstra’s Algorithm):
Calculates the shortest path between two intersections based on distance or time.
### Traffic Light Management:
Dynamic traffic light durations to control vehicle flow efficiently.
### Vehicle Addition & Priority Handling: 
Vehicles, including emergency vehicles, are managed based on priority using a priority queue.
### Dark Mode and Light Mode Toggle:
The interface allows users to switch between dark and light modes.

---


## Installation
To set up the Smart Traffic Management System locally, follow these steps:

- Requirements
- Python 3.x/
- PyQt5/6/
- QtQuick 2.15 (QML)/
- DSA-related dependencies (e.g., queue, graph-related algorithms)

### Steps:
**Clone the repository:**
```bash
git clone https://github.com/yourusername/smart-traffic-management.git
cd smart-traffic-management
```
**Create a Virtual Environment:**
```bash
python3 -m venv venv
source venv/bin/activate
```
**Install Python dependencies:**
```bash
pip install PySide6
```

**Run the system:**
```bash
python src/main.py
```
---
## Usage

**Once the system is set up:**
-You can add intersections and roads via the UI.
-Shortest paths between intersections can be computed using Dijkstra's Algorithm.
-Traffic lights can be configured based on the intersection of choice.
-Vehicles can be added to the system and managed based on priority using Priority Queues.
-You can toggle between light mode and dark mode via the UI.
-Architecture
-Graph Representation

 ---
### **The system represents the road network as a graph:**

-Intersections are the nodes.
-Roads are edges with weights representing distance or time.
-The graph is dynamic, meaning that nodes (intersections) and edges (roads) can be added, removed, or modified in real time based on traffic updates.

### Backend Logic:
The backend is written in Python, where the logic behind the traffic management system resides.
-**Graph Construction:** Uses adjacency lists to represent roads connecting intersections.
-**Shortest Path:** Dijkstra’s Algorithm is used for efficient pathfinding.
-The algorithm works with priority queues to process the graph efficiently.
-It calculates the shortest path by visiting neighboring nodes and evaluating their distance to find the shortest route.
-**Vehicle Priority Handling:** Emergency vehicles (police, ambulances) are prioritized using priority queues, ensuring they can traverse intersections with minimal delays.

### Frontend Design:
The frontend is built using QtQuick/QML for a seamless user interface. The page structure includes:
-**Roads and Intersections Page:** For adding intersections, roads, and finding shortest paths.
-**Traffic Light Management:** For setting traffic light durations based on intersections.
-**Vehicle Priority Management:** A visual interface to manage vehicles in real-time, based on their priority.
 
 ---
 
## DSA Concepts Used
This system makes use of several core data structure and algorithm concepts:

### Graph Theory:
Represents the city road network using a graph (nodes and edges).
Provides the structure necessary for dynamic road management.

### Dijkstra’s Algorithm:
Used to find the shortest path between two intersections in the graph.
Utilizes priority queues to process nodes with the least known distance.

### Priority Queues:
Used for managing vehicle priorities (especially for emergency vehicles).
Ensures efficient prioritization and handling of vehicles based on real-time requirements.

### Adjacency Lists:
Efficiently stores the road network (graph edges) and supports fast additions/removals of roads between intersections.

### Graph Representation
The graph representing the road network is constructed as an adjacency list. Each intersection is a node, and roads are weighted edges. This allows for efficient insertion and removal of intersections and roads, which is necessary for simulating real-time traffic changes.

### Adjacency List Representation:
**Nodes:** Represent intersections in the network.
**Edges:** Represent roads between intersections, with weights corresponding to the distance or travel time.

---

## Real-World Applicability
This system simulates a real-world traffic management solution:

-Urban Traffic Optimization: Ideal for modeling city traffic and testing route optimizations in smart city contexts.
-Emergency Vehicle Prioritization: Ensures that emergency vehicles can travel faster through the city using the vehicle priority queue.
-Route Optimization for Ride Services: Improves routes for ride-sharing and delivery services by optimizing traffic flow and minimizing travel time.
Future Enhancements
-Integration with Real-Time Traffic Data: Utilize data feeds from sensors or GPS systems to dynamically adjust traffic light timings and vehicle routing.
=Adaptive Traffic Control: Implement algorithms that dynamically control traffic lights based on traffic volume at different times of day.
=Simulate Road Closures and Accidents: Simulate disruptions (accidents, construction zones) to demonstrate how the system adapts and reroutes traffic.

---

## License
This project is licensed under the MIT License - see the LICENSE file for details.

