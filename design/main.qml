import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "Smart Traffic Management System"

    property bool isDarkMode: true
    color: isDarkMode ? "#1e1e1e" : "#ffffff"

    

    StackView {
        id: stackView
        anchors.fill: parent
         z: 1 // Ensure it doesn't overlap the button
        initialItem: Rectangle {
            color: isDarkMode ? "#000000" : "#ffffff"
            anchors.fill: parent

// Dark Mode Toggle Button
    Button {
        text: isDarkMode ? "Light Mode" : "Dark Mode"
        width: 90
        height:35
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
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
                spacing: 20
                anchors.centerIn: parent

                Text {
                    text: "Smart Traffic Management System"
                    
                    font.pixelSize: 35
                    font.bold: true
                    color: isDarkMode ? "#ffffff" : "#000000"
                    height: 100 
                }
                // Increase margin by adding spacing here
                //Item {
               //     height: 200 // Adjust height to set the margin
                //}

                // Add Vehicle Button
                Button {
                    text: "Add Vehicle"
                    width: 250
                    height: 55
                     
                     anchors.left: parent.left
                     anchors.margins: 150
                    background: Rectangle {
                        color: isDarkMode ? "#ffffff" : "#000000"
                        radius: 10
                        border.color: isDarkMode ? "#000000" : "#ffffff" // Dynamic border color
                        border.width: 2   
                    }
                    contentItem: Text {
                        text: "Add Vehicle"
                        color: isDarkMode ? "#000000" : "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                       font.bold: true 
                       font.pixelSize: 14
                    }
                    onClicked: {
                        stackView.push("VehiclePage.qml")
                    }
                }

                // Add Roads/Intersections Button
                Button {
                    text: "Add Roads/Intersections"
                    width: 250
                    height: 55
                     anchors.left: parent.left
                     anchors.margins: 150
                    background: Rectangle {
                        color: isDarkMode ? "#ffffff" : "#000000"
                        radius: 10
                        border.color: isDarkMode ? "#000000" : "#ffffff" // Dynamic border color
                        border.width: 2   
                    }
                    contentItem: Text {
                        text: "Add Roads/Intersections"
                        color: isDarkMode ? "#000000" : "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true 
                        font.pixelSize: 14
                    }
                    onClicked: {
                        stackView.push("RoadsAndIntersectionsPage.qml")
                    }
                }
            }
        }
    }
}
