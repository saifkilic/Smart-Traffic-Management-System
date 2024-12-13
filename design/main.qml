import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "Smart Traffic Management System"
    
    // Dark mode functionality
    property bool isDarkMode: true
    color: isDarkMode ? "#1e1e1e" : "#ffffff" // Set background color based on dark mode
    
    // Style switcher button
    Rectangle {
        width: 50
        height: 50
        color: isDarkMode ? "#FFA500" : "#444444"
        radius: 25
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20

        MouseArea {
            anchors.fill: parent
            onClicked: {
                isDarkMode = !isDarkMode // Toggle dark mode
            }
        }
    }

    // Main Layout
    Column {
        anchors.fill: parent
        spacing: 20
        padding: 20

        // Title
        Text {
            text: "Smart Traffic Management System"
            font.pixelSize: 24
            color: isDarkMode ? "#FFA500" : "#333333"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // Input Section
        Rectangle {
            width: parent.width - 40
            height: 250
            color: isDarkMode ? "#2e2e2e" : "#f0f0f0"
            radius: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Column {
                spacing: 15
                anchors.centerIn: parent

                // Add Intersection Section
                Row {
                    spacing: 15

                    TextField {
                        id: intersectionNameInput
                        placeholderText: "Enter Intersection Name"
                        width: 200
                        color: isDarkMode ? "#ffffff" : "#000000"
                        background: Rectangle {
                            color: isDarkMode ? "#333333" : "#e0e0e0"
                            radius: 5
                        }
                        focus: true
                        onActiveFocusChanged: {
                            if (activeFocus) {
                                background.color = isDarkMode ? "#444444" : "#d0d0d0"
                            } else {
                                background.color = isDarkMode ? "#333333" : "#e0e0e0"
                            }
                        }
                    }

                    Button {
                        text: "Add Intersection"
                        width: 150
                        height: 40
                        background: Rectangle {
                            color: "#FFA500"
                            radius: 5
                        }
                        contentItem: Text {
                            text: "Add Intersection"
                            color: "#ffffff"
                            anchors.centerIn: parent
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
                        color: isDarkMode ? "#ffffff" : "#000000"
                        background: Rectangle {
                            color: isDarkMode ? "#333333" : "#e0e0e0"
                            radius: 5
                        }
                    }

                    TextField {
                        id: toIntersectionInput
                        placeholderText: "To Intersection"
                        width: 150
                        color: isDarkMode ? "#ffffff" : "#000000"
                        background: Rectangle {
                            color: isDarkMode ? "#333333" : "#e0e0e0"
                            radius: 5
                        }
                    }

                    TextField {
                        id: roadWeightInput
                        placeholderText: "Distance"
                        width: 100
                        color: isDarkMode ? "#ffffff" : "#000000"
                        background: Rectangle {
                            color: isDarkMode ? "#333333" : "#e0e0e0"
                            radius: 5
                        }
                    }

                    Button {
                        text: "Add Road"
                        width: 150
                        height: 40
                        background: Rectangle {
                            color: "#FFA500"
                            radius: 5
                        }
                        contentItem: Text {
                            text: "Add Road"
                            color: "#ffffff"
                            anchors.centerIn: parent
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
                        color: isDarkMode ? "#ffffff" : "#000000"
                        background: Rectangle {
                            color: isDarkMode ? "#333333" : "#e0e0e0"
                            radius: 5
                        }
                    }

                    TextField {
                        id: endIntersectionInput
                        placeholderText: "End Intersection"
                        width: 150
                        color: isDarkMode ? "#ffffff" : "#000000"
                        background: Rectangle {
                            color: isDarkMode ? "#333333" : "#e0e0e0"
                            radius: 5
                        }
                    }

                    Button {
                        text: "Find Shortest Path"
                        width: 150
                        height: 40
                        background: Rectangle {
                            color: "#FFA500"
                            radius: 5
                        }
                        contentItem: Text {
                            text: "Find Shortest Path"
                            color: "#ffffff"
                            anchors.centerIn: parent
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
                color: isDarkMode ? "#ffffff" : "#000000"
                wrapMode: Text.WordWrap
                anchors.centerIn: parent
            }
        }
    }
}
