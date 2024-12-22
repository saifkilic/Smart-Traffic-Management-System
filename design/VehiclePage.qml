import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: vehiclePage
    property bool isDarkMode: true

    Rectangle {
        anchors.fill: parent
        color: isDarkMode ? "#1e1e1e" : "#ffffff"

        // Back Button
        Rectangle {
            width: 50
            height: 50
            color: isDarkMode ? "#60DD1D" : "#444444"
            radius: 25
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 20
            z: 10

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stackView.pop()
                }
            }

            Text {
                text: "<"
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: isDarkMode ? "#000000" : "#ffffff"
                font.pixelSize: 24
            }
        }

        // Main Layout
        Column {
            anchors.fill: parent
            spacing: 20
            padding: 20

            // Add Vehicle Section
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
                            width: 270
                            height: 40
                            font.pixelSize: 16
                            color: isDarkMode ? "#60DD1D" : "#000000"
                            background: Rectangle {
                                color: isDarkMode ? "#333333" : "#e0e0e0"
                                radius: 5
                            }
                        }

                       
                        ComboBox {
                            id: vehicleTypeInput
                            width: 270
                            height: 40
                            model: ["Select Vehicle Type", "Car", "Bus", "Bike", "Truck", "Ambulance", "Fire Truck", "Police"]
                            font.pixelSize: 16
                            background: Rectangle {
                                color: isDarkMode ? "#333333" : "#e0e0e0"
                                radius: 5
                            }
                            contentItem: Text {
                                text: vehicleTypeInput.displayText
                                color: isDarkMode ? "#ffffff" : "#000000"
                                elide: Text.ElideRight
                                font.pixelSize: 16
                                anchors.verticalCenter: parent.verticalCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        Button {
                             width: 270
                            height: 40
                            text: "Add Vehicle"
                            background: Rectangle {
                                color: "#60DD1D"
                                radius: 5
                            }
                            contentItem: Text {
                                text: "Add Vehicle"
                                color: "#000000"
                                font.pixelSize: 16
                                anchors.centerIn: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
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

            // Check Vehicles at Intersection Section
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
                           id: checkIntersectionInput
                            placeholderText: "Intersection Name"
                            width: 270
                            height: 40
                            font.pixelSize: 16
                             color: isDarkMode ? "#60DD1D" : "#000000"
                            background: Rectangle {
                                color: isDarkMode ? "#333333" : "#e0e0e0"
                                radius: 5
                            }
                        }

                        Button {
                            width: 270
                            height: 40
                            text: "Check Vehicles"
                            background: Rectangle {
                                color: "#60DD1D"
                                radius: 5
                            }
                            contentItem: Text {
                                text: "Check Vehicles"
                                color: "#000000"
                                font.pixelSize: 16
                                anchors.centerIn: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
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
                        font.pixelSize: 16
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Button {
                        width: 270
                            height: 40
                        text: "Check Total Vehicles"
                        background: Rectangle {
                            color: "#60DD1D"
                            radius: 5
                        }
                        contentItem: Text {
                            text: "Check Total Vehicles"
                            color: "#000000"
                            font.pixelSize: 16
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
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
                    font.pixelSize: 16
                    color: isDarkMode ? "#ffffff" : "#000000"
                    wrapMode: Text.WordWrap
                    anchors.centerIn: parent
                }
            }
        }
    }
}
