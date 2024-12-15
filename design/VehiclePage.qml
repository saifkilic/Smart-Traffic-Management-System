import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: vehiclePage
    property bool isDarkMode: true

    // Root rectangle to apply the color property
    Rectangle {
        anchors.fill: parent
        color: isDarkMode ? "#1e1e1e" : "#ffffff"

        // Back Button
        Rectangle {
            width: 50
            height: 50
            color: isDarkMode ? "#FFA500" : "#444444"
            radius: 25
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 20
            z: 10 // Ensure it's on top of other components

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stackView.pop()
                }
            }

            Text {
                text: "<"
                anchors.centerIn: parent
                color: isDarkMode ? "#000000" : "#ffffff"
                font.pixelSize: 24
            }
        }

        // Main Layout
        Column {
            anchors.fill: parent
            spacing: 20
            padding: 20

            // Input Section (Add Vehicle)
            Rectangle {
                width: parent.width - 40
                height: 300
                color: isDarkMode ? "#2e2e2e" : "#f0f0f0"
                radius: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    spacing: 15
                    anchors.centerIn: parent

                    Row {
                        spacing: 15

                        TextField {
                            id: vehicleIntersectionInput
                            placeholderText: "Intersection Name"
                            width: 200
                            color: isDarkMode ? "#ffffff" : "#000000"
                            background: Rectangle {
                                color: isDarkMode ? "#333333" : "#e0e0e0"
                                radius: 5
                            }
                        }

                        ComboBox {
                            id: vehicleTypeInput
                            width: 200
                            model: ["Select Vehicle Type", "Car", "Bus", "Bike", "Truck", "Ambulance", "Fire Truck", "Police"]
                        }

                        Button {
                            text: "Add Vehicle"
                            background: Rectangle {
                                color: "#FFA500"
                                radius: 5
                            }
                            contentItem: Text {
                                text: "Add Vehicle"
                                color: "#ffffff"
                            }
                            onClicked: {
    // Check if the selected vehicle type is an emergency vehicle
    var isEmergency = vehicleTypeInput.currentText === "Ambulance" || 
                      vehicleTypeInput.currentText === "Police" || 
                      vehicleTypeInput.currentText === "Fire Truck";
    
    // Call the backend to add the vehicle with the emergency flag
    backend.add_vehicle(vehicleIntersectionInput.text, vehicleTypeInput.currentText, isEmergency)
    
    outputText.text = "Vehicle added: " + vehicleTypeInput.currentText + " at " + vehicleIntersectionInput.text
    vehicleIntersectionInput.text = ""
    vehicleTypeInput.currentIndex = -1
}

                        }
                    }
                }
            }

            // Vehicle Checking Section
            Rectangle {
                width: parent.width - 40
                height: 300
                color: isDarkMode ? "#2e2e2e" : "#f0f0f0"
                radius: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    spacing: 15
                    anchors.centerIn: parent

                    // Check Vehicles at Intersection
                    Row {
                        spacing: 15

                        TextField {
                            id: checkIntersectionInput
                            placeholderText: "Intersection Name"
                            width: 200
                            color: isDarkMode ? "#ffffff" : "#000000"
                            background: Rectangle {
                                color: isDarkMode ? "#333333" : "#e0e0e0"
                                radius: 5
                            }
                        }

                        Button {
                            text: "Check Vehicles"
                            background: Rectangle {
                                color: "#FFA500"
                                radius: 5
                            }
                            contentItem: Text {
                                text: "Check Vehicles"
                                color: "#ffffff"
                            }
                            onClicked: {
                                if (checkIntersectionInput.text !== "") {
                                    var result = backend.get_vehicles_at_intersection(checkIntersectionInput.text)
                                    checkOutputText.text = result
                                }
                            }
                        }
                    }

                    Text {
                        id: checkOutputText
                        text: "Vehicles will appear here"
                        color: isDarkMode ? "#ffffff" : "#000000"
                        wrapMode: Text.WordWrap
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    // Total Vehicles Section
                    Button {
                        text: "Check Total Vehicles"
                        background: Rectangle {
                            color: "#FFA500"
                            radius: 5
                        }
                        contentItem: Text {
                            text: "Check Total Vehicles"
                            color: "#ffffff"
                        }
                        onClicked: {
                            var result = backend.get_total_vehicles()
                            totalOutputText.text = "Total vehicles: " + result
                        }
                    }

                    Text {
                        id: totalOutputText
                        text: "Total vehicles will appear here"
                        color: isDarkMode ? "#ffffff" : "#000000"
                        wrapMode: Text.WordWrap
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            // Output Section
            Rectangle {
                width: parent.width - 40
                height: 150
                color: isDarkMode ? "#2e2e2e" : "#f0f0f0"
                radius: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: outputText
                    text: "Output will appear here"
                    color: isDarkMode ? "#ffffff" : "#000000"
                    wrapMode: Text.WordWrap
                    anchors.centerIn: parent
                }
            }
        }
    }
}
