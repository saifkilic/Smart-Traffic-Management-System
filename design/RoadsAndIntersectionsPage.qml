import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: roadsPage
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

            // Input Section
            Rectangle {
                width: parent.width - 40
                height: 300
                color: isDarkMode ? "#2e2e2e" : "#f0f0f0"
                radius: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    spacing: 15
                    anchors.centerIn: parent

                    // Add Intersection
                    Row {
                        spacing: 15

                        TextField {
                            id: intersectionNameInput
                            placeholderText: "Enter Intersection Name"
                            width: 200
                            color: "#ffffff"
                            background: Rectangle {
                                color: "#333333"
                                radius: 5
                            }
                            focus: true
                            // Add a focus effect
                            onActiveFocusChanged: {
                                if (activeFocus) {
                                    background.color = "#444444" // Lighten background when focused
                                } else {
                                    background.color = "#333333" // Default dark color
                                }
                            }
                        }

                        Button {
                            text: "Add Intersection"
                            background: Rectangle {
                                color: "#FFA500"
                                radius: 5
                            }
                            contentItem: Text {
                                text: "Add Intersection"
                                color: "#ffffff"
                            }
                            onClicked: {
                                backend.add_intersection(intersectionNameInput.text)
                                intersectionNameInput.text = ""  // Clear input after clicking
                            }
                        }
                    }

                    // Add Road Section
                    Row {
                        spacing: 15

                        TextField {
                            id: fromIntersectionInput
                            placeholderText: "From Intersection"
                            width: 150
                            color: "#ffffff"
                            background: Rectangle {
                                color: "#333333"
                                radius: 5
                            }
                        }

                        TextField {
                            id: toIntersectionInput
                            placeholderText: "To Intersection"
                            width: 150
                            color: "#ffffff"
                            background: Rectangle {
                                color: "#333333"
                                radius: 5
                            }
                        }

                        TextField {
                            id: roadWeightInput
                            placeholderText: "Distance"
                            width: 100
                            color: "#ffffff"
                            background: Rectangle {
                                color: "#333333"
                                radius: 5
                            }
                        }

                        Button {
                            text: "Add Road"
                            background: Rectangle {
                                color: "#FFA500"
                                radius: 5
                            }
                            contentItem: Text {
                                text: "Add Road"
                                color: "#ffffff"
                            }
                            onClicked: {
                                backend.add_road(fromIntersectionInput.text, toIntersectionInput.text, parseInt(roadWeightInput.text))
                                outputText.text = "Road added: " + fromIntersectionInput.text + " to " + toIntersectionInput.text + " (Weight: " + roadWeightInput.text + ")"
                                fromIntersectionInput.text = ""
                                toIntersectionInput.text = ""
                                roadWeightInput.text = ""
                            }
                        }
                    }

                    // Find Shortest Path Section
                    Row {
                        spacing: 15

                        TextField {
                            id: startIntersectionInput
                            placeholderText: "Start Intersection"
                            width: 150
                            color: "#ffffff"
                            background: Rectangle {
                                color: "#333333"
                                radius: 5
                            }
                        }

                        TextField {
                            id: endIntersectionInput
                            placeholderText: "End Intersection"
                            width: 150
                            color: "#ffffff"
                            background: Rectangle {
                                color: "#333333"
                                radius: 5
                            }
                        }

                        Button {
                            text: "Find Shortest Path"
                            background: Rectangle {
                                color: "#FFA500"
                                radius: 5
                            }
                            contentItem: Text {
                                text: "Find Shortest Path"
                                color: "#ffffff"
                            }
                            onClicked: {
                                var result = backend.find_shortest_path(startIntersectionInput.text, endIntersectionInput.text)
                                outputText.text = result
                            }
                        }
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
                    color: "#ffffff"
                    wrapMode: Text.WordWrap
                    anchors.centerIn: parent
                }
            }
        }
    }
}
