import sys
from pathlib import Path

# Add the 'src' directory to the Python module search path
current_dir = Path(__file__).resolve().parent
backend_dir = current_dir / "backend"
sys.path.insert(0, str(current_dir))
sys.path.insert(0, str(backend_dir))

from backend.graph import Graph  # Import Graph after updating sys.path

# Rest of the main.py code
import sys
from PySide6.QtCore import QUrl, QObject, Slot
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

class Backend(QObject):
    def __init__(self):
        super().__init__()
        self.graph = Graph()

    @Slot(str)
    def add_intersection(self, name):
        self.graph.add_node(name)
        print(f"Added intersection: {name}")

    @Slot(str, str, int)
    def add_road(self, from_intersection, to_intersection, weight):
        self.graph.add_edge(from_intersection, to_intersection, weight)
        print(f"Added road from {from_intersection} to {to_intersection} with weight {weight}")

    @Slot(str, str, result=str)
    def find_shortest_path(self, start, end):
        distance = self.graph.shortest_path(start, end)
        if distance == float('inf'):
            return f"No path found between {start} and {end}"
        return f"Shortest path from {start} to {end} is {distance}"

def main():
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    backend = Backend()
    engine.rootContext().setContextProperty("backend", backend)
    engine.load(QUrl("design/main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())

if __name__ == "__main__":
    main()
