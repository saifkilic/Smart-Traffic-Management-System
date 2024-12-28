import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: roadsPage
    property bool isDarkMode: true

    ScrollView {
        anchors.fill: parent

        Rectangle {
            width: parent.width
            height: contentHeight
            color: isDarkMode ? "#000000" : "#ffffff"

            // Back Button
            Rectangle {
                width: 80
                height: 30
                color: isDarkMode ? "#ffffff" : "#000000"
                radius: 8
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

            // Dark Mode Toggle Button
    Button {
        text: isDarkMode ? "Light Mode" : "Dark Mode"
        width: 90
        height:35
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        z:2
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

            // Main Layout
            Column {
                anchors.fill: parent
                spacing: 0
                padding: 0

                // Input Section: Add Intersection
                Rectangle {
                    width: parent.width
                    height: 300
                    color: isDarkMode ? "#000000" : "#ffffff"
                    radius: 1
                    anchors.horizontalCenter: parent.horizontalCenter
 Text {
                            id: errorMessage
                            text: "" // Initially empty
                            color: "#ff0000"
                            font.pixelSize: 14
                            visible: text !== "" // Show only if text is not empty
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                    Column {
                        spacing: 15
                        anchors.centerIn: parent

                        Row {
                            spacing: 10
                            TextField {
                                id: intersectionNameInput
                                placeholderText: "Enter Intersection Name"
                                width: 470
                                height: 30
                                placeholderTextColor: isDarkMode ? "#878787" : "#888888"
                                background: Rectangle {
                                    color: isDarkMode ? "#ffffff" : "#000000"
                                    radius: 5
                                }
                            }

                            Button {
                                text: "Add Intersection"
                                width: 150
                                height: 30
                                background: Rectangle {
                                    color: "#00ff00"
                                    radius: 5
                                }
                                contentItem: Text {
                                    text: "Add Intersection"
                                    color: "#000000"
                                    font.bold:true
                                }
                                onClicked: {
                                    if (intersectionNameInput.text === "") {
                                        errorMessage.text = "Intersection name cannot be empty."
                                    } else {
                                        backend.add_intersection(intersectionNameInput.text)
                                        intersectionNameInput.text = ""
                                        errorMessage.text = "" // Clear the error if successful
                                    }
                                }
                            }
                        }

                        // Add Road Section
                        Row {
                            spacing: 10
                            TextField {
                                id: fromIntersectionInput
                                placeholderText: "From Intersection"
                                width: 150
                                height: 30
                                placeholderTextColor: isDarkMode ? "#878787" : "#888888"
                                background: Rectangle {
                                    color: isDarkMode ? "#ffffff" : "#000000"
                                    radius: 5
                                }
                            }

                            TextField {
                                id: toIntersectionInput
                                placeholderText: "To Intersection"
                                width: 150
                                height: 30
                                placeholderTextColor: isDarkMode ? "#878787" : "#888888"
                                background: Rectangle {
                                   color: isDarkMode ? "#ffffff" : "#000000"
                                    radius: 5
                                }
                            }

                            TextField {
                                id: roadWeightInput
                                placeholderText: "Road Distance"
                                width: 150
                                height: 30
                                placeholderTextColor: isDarkMode ? "#878787" : "#888888"
                                background: Rectangle {
                                    color: isDarkMode ? "#ffffff" : "#000000"
                                    radius: 5
                                }
                            }

                            Button {
                                text: "Add Road"
                                width: 150
                                height: 30
                                background: Rectangle {
                                    color: "#00ff00"
                                    radius: 5
                                }
                                contentItem: Text {
                                    text: "Add Road"
                                    color: "#000000"
                                    font.bold:true
                                }
                                onClicked: {
                                     if (fromIntersectionInput.text === "" || toIntersectionInput.text === "" || roadWeightInput.text === "") {
                                        errorMessage.text = "Please fill all fields to add a road."
                                    } else {
                                        backend.add_road(fromIntersectionInput.text, toIntersectionInput.text, parseInt(roadWeightInput.text))
                                        fromIntersectionInput.text = ""
                                        toIntersectionInput.text = ""
                                        roadWeightInput.text = ""
                                        errorMessage.text = "" // Clear the error if successful
                                    }
                                }
                            }
                        }

                        Row {
                            spacing: 10
                            TextField {
                                id: startIntersectionInput
                                placeholderText: "Start Intersection"
                                width: 230
                                height: 30
                                placeholderTextColor: isDarkMode ? "#878787" : "#888888"
                                background: Rectangle {
                                    color: isDarkMode ? "#ffffff" : "#000000"
                                    radius: 5
                                }
                            }

                            TextField {
                                id: endIntersectionInput
                                placeholderText: "End Intersection"
                                width: 230
                                height: 30
                                placeholderTextColor: isDarkMode ? "#878787" : "#888888"
                                background: Rectangle {
                                    color: isDarkMode ? "#ffffff" : "#000000"
                                    radius: 5
                                }
                            }

                            Button {
                                text: "Find Shortest Path"
                                width: 150
                                height: 30
                                background: Rectangle {
                                    color: "#00ff00"
                                    radius: 5
                                }
                                contentItem: Text {
                                    text: "Find Shortest Path"
                                    color: "#000000"
                                    font.bold:true
                                }
                                onClicked: {
                                    shortestPathOutput.text = backend.shortest_path(startIntersectionInput.text, endIntersectionInput.text)
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
                        }
                    }
                }

                // Traffic Light Section
                Rectangle {
                    width: parent.width
                    height: 350
                    color: isDarkMode ? "#ffffff" : "#000000"
                    radius: 1
                    anchors.horizontalCenter: parent.horizontalCenter

                    Column {
                        spacing: 15
                        anchors.centerIn: parent

                        Row {
                            spacing: 10
                            TextField {
                                id: trafficLightIntersection
                                placeholderText: "Enter Intersection Name"
                                width: 200
                                height: 30
                                placeholderTextColor: isDarkMode ? "#878787" : "#888888"
                                background: Rectangle {
                                    color: isDarkMode ? "#000000" : "#ffffff"
                                    radius: 5
                                }
                            }

                            Button {
                                text: "Get Light Duration"
                                width: 180
                                height: 30
                                background: Rectangle {
                                    color: "#00ff00"
                                    radius: 5
                                }
                                contentItem: Text {
                                    text: "Get Light Duration"
                                    color:  isDarkMode ? "#000000" : "#ffffff"
                                    font.bold:true
                                }
                                onClicked: { if (trafficLightIntersection.text === "") {
                lightOutputText.text = "Error: Intersection name cannot be empty."
                lightOutputText.color = "#ff0000" // Display error in red
            } else {
                var duration = backend.get_traffic_light_duration(trafficLightIntersection.text)
                lightOutputText.text = "Light Duration at " + trafficLightIntersection.text + ": " + duration + " seconds"
                lightOutputText.color = isDarkMode ? "#ffffff" : "#000000" // Reset to normal color
            }}
                            }
                        }

                        Text {
                            id: lightOutputText
                            text: "Traffic light info will appear here"
                            font.pixelSize: 16
                            color: isDarkMode ? "#000000" : "#ffffff"
                            wrapMode: Text.WordWrap
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }
    }
}
