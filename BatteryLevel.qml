import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: batteryLevelRect
    color: getBatteryColor()
    radius: 10

    property string notchColor: "white"

    function getBatteryColor() {
        if (window.batteryPercentage >= 70) {
            return "darkgreen"
        } else if (window.batteryPercentage >= 30) {
            return "darkorange"
        } else {
            return "firebrick"
        }
    }
    Rectangle {
        id: notch
        x: 93
        y: 20
        rotation: 90
        height: 10
        width: 20
        color: batteryLevelRect.notchColor
    }

    Timer {
        interval: 10
        running: true
        repeat: true
        onTriggered: {
            updateBatteryNotchColor()
        }
    }

    function updateBatteryNotchColor() {
        if (window.batteryPercentage >= 100) {
            notchColor = "white"
        } else if (window.batteryPercentage >= 70) {
            notchColor = "darkgreen"
        } else if (window.batteryPercentage >= 30) {
            notchColor = "darkorange"
        } else{
            notchColor = "firebrick"
        }

        }

    Rectangle {
        id: batteryLevelIndicator
        radius: 10
        width: batteryLevelRect.width * (window.batteryPercentage / 100)
        height: batteryLevelRect.height
        color: "white"
    }


    }


