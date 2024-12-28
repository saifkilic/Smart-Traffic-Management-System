import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: vehiclePage
    property bool isDarkMode: true

    Rectangle {
        anchors.fill: parent
        color: isDarkMode ? "#000000" : "#ffffff"

        // Back Button
        Rectangle {
            width: 80
            height: 30
            color: isDarkMode ? "#ffffff" : "#000000"
            radius: 10
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 20

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

        // Dark Mode Toggle Button
        Button {
            text: isDarkMode ? "Light Mode" : "Dark Mode"
            width: 90
            height: 35
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 10
            z: 2
            background: Rectangle {
                color: isDarkMode ? "#ffffff" : "#000000"
                radius: 10
            }
            contentItem: Text {
                text: isDarkMode ? "Light Mode" : "Dark Mode"
                color: isDarkMode ? "#000000" : "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.pixelSize: 14
            }
            onClicked: {
                isDarkMode = !isDarkMode
            }
        }

        Column {
            anchors.fill: parent
            spacing: 20
            padding: 20

            // Input Section
            Rectangle {
                width: parent.width - 40
                height: 300
                color: isDarkMode ? "#000000" : "#ffffff"
                radius: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    spacing: 20
                    anchors.centerIn: parent

                    TextField {
                        id: vehicleIntersectionInput
                        placeholderText: "Intersection Name"
                        placeholderTextColor: isDarkMode ? "#878787" : "#888888"
                        width: 200
                        height: 30
                        color: isDarkMode ? "#000000" : "#ffffff"
                        background: Rectangle {
                            color: isDarkMode ? "#ffffff" : "#000000"
                            radius: 5
                        }
                    }

                    ComboBox {
                        id: vehicleTypeInput
                        width: 200
                        height: 30
                        model: ["Select Vehicle Type", "Car", "Bus", "Bike", "Truck", "Ambulance", "Fire Truck", "Police"]

                        delegate: ItemDelegate {
                            contentItem: Text {
                                text: modelData
                                color: isDarkMode ? "#000000" : "#000000"
                            }
                        }

                        onCurrentIndexChanged: {
                            console.log("Selected: " + currentText)
                        }
                    }

                   Button {
                        text: "Add Vehicle"
                        background: Rectangle {
                            color: "#00ff00"
                            radius: 5
                        }
                        contentItem: Text {
                            text: "Add Vehicle"
                            color: "#000000"
                            font.bold: true
                        }
                        onClicked: {
                            if (vehicleIntersectionInput.text.trim() === "") {
                                outputAddText.text = "Error: Intersection name cannot be empty.";
                                outputAddText.color = "#ff0000";
                            } else if (vehicleTypeInput.currentIndex === 0) {
                                outputAddText.text = "Error: Please select a valid vehicle type.";
                                outputAddText.color = "#ff0000";
                            } else {
                                var isEmergency = vehicleTypeInput.currentText === "Ambulance" ||
                                                  vehicleTypeInput.currentText === "Police" ||
                                                  vehicleTypeInput.currentText === "Fire Truck";

                                try {
                                    backend.add_vehicle(
                                        vehicleIntersectionInput.text.trim(),
                                        vehicleTypeInput.currentText,
                                        isEmergency
                                    );
                                    outputAddText.text = `Vehicle added: ${vehicleTypeInput.currentText} at ${vehicleIntersectionInput.text.trim()}`;
                                    outputAddText.color = isDarkMode ? "#ffffff" : "#000000";
                                    vehicleIntersectionInput.text = "";
                                    vehicleTypeInput.currentIndex = 0;
                                } catch (error) {
                                    outputAddText.text = `Error: Unable to add vehicle. ${error}`;
                                    outputAddText.color = "#ff0000";
                                }
                            }
                        }
                    }

                    Text {
                        id: outputAddText
                        text: "Output will appear here"
                        color: isDarkMode ? "#ffffff" : "#000000"
                        wrapMode: Text.WordWrap
                    }
                }
            }


            // Vehicle Checking Section
            Rectangle {
                width: parent.width
                height: 300
                color: isDarkMode ? "#ffffff" : "#000000"
                radius: 1
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    spacing: 20
                    anchors.centerIn: parent

                    TextField {
                        id: checkIntersectionInput
                        placeholderText: "Intersection Name"
                        placeholderTextColor: isDarkMode ? "#878787" : "#888888"
                        width: 200
                        height: 30
                        color: isDarkMode ? "#ffffff" : "#000000"
                        background: Rectangle {
                            color: isDarkMode ? "#000000" : "#ffffff"
                            radius: 5
                        }
                    }

                    Button {
                        text: "Check Vehicles"
                        width: 90
                        height: 28
                        background: Rectangle {
                            color: "#00ff00"
                            radius: 5
                        }
                        contentItem: Text {
                            text: "Check Vehicles"
                            color: "#000000"
                            font.bold: true
                        }
                        onClicked: {
                            if (checkIntersectionInput.text === "") {
                                checkOutputText.text = "Error: Intersection name cannot be empty.";
                                checkOutputText.color = "#ff0000"; // Display error in red
                            } else {
                                var result = backend.get_vehicles_at_intersection(checkIntersectionInput.text);
                                checkOutputText.text = result;
                                checkOutputText.color = isDarkMode ? "#ffffff" : "#000000"; // Reset to normal color
                            }
                        }
                    }

                    Text {
                        id: checkOutputText
                        text: "Vehicles will appear here"
                        color: isDarkMode ? "#000000" : "#ffffff"
                        wrapMode: Text.WordWrap
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Button {
                        text: "Check Total Vehicles"
                        width: 90
                        height: 28
                        background: Rectangle {
                            color: "#00ff00"
                            radius: 5
                        }
                        contentItem: Text {
                            text: "Total Vehicles"
                            color: "#000000"
                            font.bold: true
                        }
                        onClicked: {
                            var result = backend.get_total_vehicles();
                            totalOutputText.text = "Total vehicles: " + result;
                        }
                    }

                    Text {
                        id: totalOutputText
                        text: "Total vehicles will appear here"
                        color: isDarkMode ? "#000000" : "#ffffff"
                        wrapMode: Text.WordWrap
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            // Output Section
            Rectangle {
                width: parent.width - 40
                height: 150
                color: isDarkMode ? "#000000" : "#f0f0f0"
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
