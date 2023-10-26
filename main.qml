import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Window

ApplicationWindow {
    id: window
    visible: true
    width: 300
    height: 500
    title: "Bicycle Infotainment"
    color: "grey"

    property int speed: 0
    property int durationHours: 0
    property int durationMinutes: 0
    property int durationSeconds: 0
    property bool isRunning: false
    property real totalDistanceTravelled: 0
    property int totalSeconds: 0
    property int batteryPercentage: 100
    property int speedBeforePause: 0

    MediaPlayer {
        id: music
        source: "bicycle_bell.mp3"
        audioOutput: AudioOutput {}
    }

    Slider {
        id: speedSlider
        from: 0
        to: 30
        value: speed
        stepSize: 1
        live: true
        rotation: -90
        x: 900
        y: 400

        onValueChanged: {
            speed = Math.round(value)
            updateTotalDistance()
            updateBatteryLevel()

        }
    }

    Timer {
        id: timer
        interval: 1000
        running: isRunning
        repeat: true
        onTriggered: {
            totalSeconds += 1 // Increment the total seconds

            // Convert totalSeconds to hours, minutes, and remaining seconds
            durationHours = Math.floor(totalSeconds / 3600)
            durationMinutes = Math.floor((totalSeconds % 3600) / 60)
            durationSeconds = totalSeconds % 60
            updateTotalDistance()
            updateBatteryLevel()

        }
    }

    function updateTotalDistance() {
        var segmentDistance = (speed * (durationHours * 3600 + durationMinutes * 60 + durationSeconds))/10000;
           totalDistanceTravelled += segmentDistance;
    }

    function updateBatteryLevel() {
        if (speed > 15) {
            batteryPercentage -= 1
            if (batteryPercentage < 0) {
                batteryPercentage = 0
            }

        }
        qtquit()
    }
    function qtquit()
    {
        if(batteryPercentage===0)
        {
            Qt.quit()
        }
    }
    SpeedoMeter {
        height: 400
        width: 315
        x: 610
        y: 180
    }

    Rectangle {
        id: rect1
        width: 300
        height: 400
        anchors.centerIn: parent
        color: "black"
        radius: height / 6
        clip:true
        Text {
            text: "BICYCLE INFOTAINMENT"
            font.family: "Helvetica"
            x: 30
            y: 20
            color: "white"
            font.pixelSize: 20
            font.bold: true
        }

        Column {
            spacing: 20
            anchors.centerIn: parent

            Row {
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: rectsp
                    color: "grey"
                    radius: 10
                    height: 50
                    width: 100

                    Label {
                        id: lbspeed
                        anchors.centerIn: parent
                        text: " " + speed + " km/hr"
                        font.pixelSize: 22
                        font.family: "Trebuchet MS"
                        horizontalAlignment: Text.AlignHCenter
                        color: {
                            if (speed >= 1 && speed <= 10) {
                                return "darkgreen";
                            } else if (speed >= 11 && speed <= 20) {
                                return "darkorange";
                            } else if (speed >= 21 && speed <= 30) {
                                return "red";
                            } else {
                                return "white";
                            }
                        }
                    }
                }

                Rectangle {
                    id: rectdu
                    color: "gray"
                    radius: 10
                    height: 50
                    width: 100

                    Label {
                        anchors.centerIn: parent
                        text: " " + padZero(durationHours) + ":" + padZero(durationMinutes) + ":" + padZero(durationSeconds)
                        font.pixelSize: 20
                        color:"white"
                        font.family: "Trebuchet MS"
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }

            Row {
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: recttdt
                    color: "gray"
                    radius: 10
                    height: 50
                    width: 100

                    Label {
                        anchors.centerIn: parent
                        text: " " + totalDistanceTravelled.toFixed(2) + " km"
                        font.pixelSize: 20
                        color:"white"
                        font.family: "Trebuchet MS"
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                Rectangle {
                    id: batteryRect
                    color: "transparent"
                    radius: 10
                    height: 50
                    width: 100

                    Label {
                        anchors.centerIn: parent
                        text: "" + batteryPercentage + "%"
                        font.pixelSize: 20
                        color:"white"
                        font.family: "Trebuchet MS"
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }

            Row {
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Button {
                    text: isRunning ? "Pause" : "Play"
                    onClicked: {
                        isRunning = !isRunning
                        if (isRunning)
                            timer.start()
                        else
                            timer.stop()
                    }
                    background: Rectangle {
                        color: isRunning ? "yellow" : "navy"
                        radius: width / 2
                        implicitWidth: 100
                        implicitHeight: 40
                    }
                }

                Button {
                    text: isRunning ? "Stop" : "Start"

                    onClicked: {
                        if (isRunning) {
                            isRunning = false;
                            speedBeforePause = speed;
                            speed = 0;
                            timer.stop();
                        } else {
                            isRunning = true;
                            speed = speedBeforePause;
                            timer.start();
                        }
                    }
                    background: Rectangle {
                        color: isRunning ? "red" : "green"
                        radius: width / 2
                        implicitWidth: 100
                        implicitHeight: 40
                    }
                }
            }
        }

        DelayButton {
            id: bellButton
            text: "Bell"
            x: 50
            anchors.horizontalCenter: rect1.horizontalCenter
            anchors.bottom: rect1.bottom
            anchors.bottomMargin: 50
            onClicked: {
                music.play()
            }
            background: Rectangle {
                color: "lightyellow"
                radius: width / 2
                implicitWidth: 100
                implicitHeight: 40
            }
        }

        RoadAnimation {
            height: 30
            width: 40
            x: 100
            y: 180
        }
        Image{
            x:10;y:300
            width:75;height:75
            id:imglogo
            source:"pixelLogo"
        }
    }

    Row {
        spacing: 5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: rect1.top

        Rectangle {
            id: hourRect
            color: "grey"
            radius: 10
            height: 40
            width: 30
            x: 100
            y: 100

            Label {
                anchors.centerIn: parent
                text: ":"
                color:"white"
                font.pixelSize: 15
                font.family: "Trebuchet MS"
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Rectangle {
            id: minuteRect
            color: "grey"
            radius: 10
            height: 40
            width: 30
            x: 100
            y: 100

            Label {
                anchors.centerIn: parent
                text: ":"
                color:"white"
                font.pixelSize: 15
                font.family: "Trebuchet MS"
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Rectangle {
            id: secondRect
            color: "transparent"
            radius: 10
            height: 40
            width: 30
            x: 100
            y: 100

            Label {
                anchors.centerIn: parent
                text: ":"
                color:"transparent"
                font.pixelSize: 15
                font.family: "Trebuchet MS"
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Rectangle {
            id: dayRect
            color: "gray"
            radius: 10
            height: 40
            width: 30
            x: 100
            y: 100

            Label {
                anchors.centerIn: parent
                text: ""
                font.pixelSize: 15
                color:"white"
                font.family: "Trebuchet MS"
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Rectangle {
            id: monthRect
            color: "gray"
            radius: 10
            height: 40
            width: 30
            x: 100
            y: 100

            Label {
                anchors.centerIn: parent
                text: ""
                font.pixelSize: 15
                color:"white"
                font.family: "Trebuchet MS"
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Rectangle {
            id: yearRect
            color: "gray"
            radius: 10
            height: 40
            width: 50
            x: 100
            y: 100

            Label {
                anchors.centerIn: parent
                text: ""
                font.pixelSize: 15
                color:"white"
                font.family: "Trebuchet MS"
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            var now = new Date()
            var hours = now.getHours()
            var minutes = now.getMinutes()
            var seconds = now.getSeconds()
            var ampm = hours >= 12 ? "PM" : "AM"

            hours = hours % 12
            hours = hours === 0 ? 12 : hours // Convert to 12-hour format and handle midnight (12 AM)

            hourRect.children[0].text = hours.toString()
            minuteRect.children[0].text = padZero(minutes)
            secondRect.children[0].text = padZero(seconds)
            dayRect.children[0].text = padZero(now.getDate())
            monthRect.children[0].text = padZero(now.getMonth() + 1)
            yearRect.children[0].text = now.getFullYear()
            hourRect.children[1].text = ampm
        }
    }

    function padZero(number) {
        return number < 10 ? "0" + number : number
    }

    BatteryLevel {
        id: batteryLevel
        radius: 10
        height: 50
        width: 100
        x: 779
        y: 377

    }
    Image{
        id: imgclock
        x:630;y:265
        height:20;width:20

        source:"clock.png"
    }
    Image {
        height:20;width:20
        x:730;y:265
        id: imgcal
        source: "calendar.png"
    }
    Image{
        id:imgboult
        height:20;width:20
        x: 816
        y: 390
        //rotation:90
        source: "batteryboult.svg"
    }


}
