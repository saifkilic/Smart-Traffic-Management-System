import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "Smart Traffic Management System"

    property bool isDarkMode: true
    color: isDarkMode ? "#1e1e1e" : "#ffffff"

    // Dark Mode Toggle Button
    Button {
        text: isDarkMode ? "Light Mode" : "Dark Mode"
        width: 120
        height: 40
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        background: Rectangle {
            color: isDarkMode ? "#FFA500" : "#444444"
            radius: 10
        }
        onClicked: {
            isDarkMode = !isDarkMode
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Rectangle {
            color: isDarkMode ? "#2e2e2e" : "#f0f0f0"
            anchors.fill: parent

            Column {
                spacing: 20
                anchors.centerIn: parent

                Text {
                    text: "Welcome to Smart Traffic Management System"
                    font.pixelSize: 20
                    color: isDarkMode ? "#ffffff" : "#000000"
                }

                // Add Vehicle Button
                Button {
                    text: "Add Vehicle"
                    width: 150
                    height: 40
                    onClicked: {
                        stackView.push("VehiclePage.qml")
                    }
                }

                // Add Roads/Intersections Button
                Button {
                    text: "Add Roads/Intersections"
                    width: 200
                    height: 40
                    onClicked: {
                        stackView.push("RoadsAndIntersectionsPage.qml")
                    }
                }
            }
        }
    }
}
