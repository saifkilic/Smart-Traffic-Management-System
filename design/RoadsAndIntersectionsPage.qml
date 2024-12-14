import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: roadsPage
    property bool isDarkMode: true

    ScrollView {
        anchors.fill: parent

        Rectangle {
            width: parent.width
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
                    color: isDarkMode ? "#000000" : "#ffffff"
                    font.pixelSize: 24
                }
            }

            // Main Layout
            Column {
                anchors.fill: parent
                spacing: 20
                padding: 20

                // Input Section: Add Intersection
                Rectangle {
                    width: parent.width - 40
                    height: 300
                    color: isDarkMode ? "#2e2e2e" : "#f0f0f0"
                    radius: 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    Column {
                        spacing: 15
                        anchors.centerIn: parent

                        // Intersection input
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
                                    intersectionNameInput.text = ""
                                }
                            }
                        }

                        // Add Road Section
                        Row {
                            spacing: 15
                            TextField {
                                id: fromIntersectionInput
                                placeholderText: "From Intersection"
                                width: 200
                                color: isDarkMode ? "#ffffff" : "#000000"
                                background: Rectangle {
                                    color: isDarkMode ? "#333333" : "#e0e0e0"
                                    radius: 5
                                }
                            }

                            TextField {
                                id: toIntersectionInput
                                placeholderText: "To Intersection"
                                width: 200
                                color: isDarkMode ? "#ffffff" : "#000000"
                                background: Rectangle {
                                    color: isDarkMode ? "#333333" : "#e0e0e0"
                                    radius: 5
                                }
                            }

                            TextField {
                                id: roadWeightInput
                                placeholderText: "Road Distance"
                                width: 100
                                color: isDarkMode ? "#ffffff" : "#000000"
                                background: Rectangle {
                                    color: isDarkMode ? "#333333" : "#e0e0e0"
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
                                    fromIntersectionInput.text = ""
                                    toIntersectionInput.text = ""
                                    roadWeightInput.text = ""
                                }
                            }
                        }

                         Row {
                            spacing: 15

                            TextField {
                                id: startIntersectionInput
                                placeholderText: "Start Intersection"
                                width: 200
                                color: isDarkMode ? "#ffffff" : "#000000"
                                background: Rectangle {
                                    color: isDarkMode ? "#333333" : "#e0e0e0"
                                    radius: 5
                                }
                            }

                            TextField {
                                id: endIntersectionInput
                                placeholderText: "End Intersection"
                                width: 200
                                color: isDarkMode ? "#ffffff" : "#000000"
                                background: Rectangle {
                                    color: isDarkMode ? "#333333" : "#e0e0e0"
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
                                    shortestPathOutput.text = result
                                }
                            }
                        }

                        Text {
                            id: shortestPathOutput
                            text: "Shortest path info will appear here"
                            font.pixelSize: 16
                            color: isDarkMode ? "#ffffff" : "#000000"
                            wrapMode: Text.WordWrap
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible: shortestPathOutput.text !== "Shortest path info will appear here"
                        }
                    }
                }

                // Traffic Light Section
                Rectangle {
                    width: parent.width - 40
                    height: 200
                    color: isDarkMode ? "#2e2e2e" : "#f0f0f0"
                    radius: 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    Column {
                        spacing: 15
                        anchors.centerIn: parent

                        Row {
                            spacing: 15

                            TextField {
                                id: trafficLightIntersection
                                placeholderText: "Enter Intersection Name"
                                width: 200
                                color: isDarkMode ? "#ffffff" : "#000000"
                                background: Rectangle {
                                    color: isDarkMode ? "#333333" : "#e0e0e0"
                                    radius: 5
                                }
                            }

                            Button {
                                text: "Get Light Duration"
                                background: Rectangle {
                                    color: "#FFA500"
                                    radius: 5
                                }
                                contentItem: Text {
                                    text: "Get Light Duration"
                                    color: "#ffffff"
                                }
                                onClicked: {
                                    var duration = backend.get_traffic_light_duration(trafficLightIntersection.text)
                                    lightOutputText.text = "Light Duration at " + trafficLightIntersection.text + ": " + duration + " seconds"
                                }
                            }
                        }

                        Text {
                            id: lightOutputText
                            text: "Traffic light info will appear here"
                            font.pixelSize: 16
                            color: isDarkMode ? "#ffffff" : "#000000"
                            wrapMode: Text.WordWrap
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible: lightOutputText.text !== "Traffic light info will appear here"
                        }
                    }
                }

                // General Output Section
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
}
