import QtQuick 6.0
import QtQuick.Controls 6.0
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 1280
    height: 612
    title: "Traffic Management System"

    // Dark Mode Property
    property bool isDarkMode: true

    // Background Image for Dark and Light Mode
    Rectangle {
        anchors.fill: parent

        // Background Image
        Image {
            source: isDarkMode ? "darkmode.svg" : "lightmode.svg"  // Set correct image paths
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
        }

        // StackView for navigation
        StackView {
            id: stackView
            anchors.fill: parent
            initialItem: homePage

            // Home Page Component
            Component {
                id: homePage
                Rectangle {
                    width: 1280
                    height: 612
                    color: "transparent"  // Transparent background to show image

                    // Dark Mode Toggle Button (Top Right)
                    Button {
                          height: 61
    anchors.top: parent.top
    anchors.right: parent.right
    anchors.topMargin: 30
    anchors.rightMargin: 25
    background: Rectangle {
        color: "transparent"
        radius: width / 2  // Circle radius is half of the width
        border.color: "transparent"  // No border during hover
    }
    // Disable hover effects
    highlighted: false  // Disable internal hover state
    hoverEnabled: false // Ensure no visual hover behavior
 
                        onClicked: isDarkMode = !isDarkMode
                    }

                    // Button Section for Navigation
                     ColumnLayout  {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 20

                        Rectangle {
                            width: 320
                            height: 65
                            radius: 23
                            color: "#60DD1D"  // Green background
                            border.color: "transparent"

                            Text {
                                text: "Vehicle Manager"
                                font.pixelSize: 18
                                color: isDarkMode ? "black" : "white"
                                anchors.centerIn: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }

                            MouseArea {
                                anchors.fill: parent
                               onClicked: {
                        stackView.push("VehiclePage.qml")
                    }
                            }
                        }

                        Rectangle {
                            width: 320
                            height: 65
                            radius: 23
                            color: "#60DD1D"  // Blue background
                            border.color: "transparent"

                            Text {
                                text: "Roads and Intersections"
                                font.pixelSize: 18
                                color: isDarkMode ? "black" : "white"
                                anchors.centerIn: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }

                            MouseArea {
                                anchors.fill: parent
                                 onClicked: {
                        stackView.push("RoadsAndIntersectionsPage.qml")
                    }
                            }
                        }
                    }
                }
            }

           

           
        }
    }
}
