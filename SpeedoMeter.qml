import QtQuick 2.15
import QtQuick.Controls 2.15

Item{

    Rectangle {
        id: rectmeter
        width: 60
        height:400
        anchors.bottom: parent.bottom
        radius:100
        //clip: true
        gradient: Gradient {
            GradientStop { position: 0; color: "red" }
            GradientStop { position: 1 - speed / 10; color: "yellow" }
            GradientStop { position: 1 - speed / 10; color: "red" }
            GradientStop { position: 1; color: "green" }
        }
        NumberAnimation {
            target: rectmeter
            property: "height"
            from:speedSlider.value>0
            to:speedSlider.value<=10
            //to: parent.height * (1 - speed / 10)
            duration: 500
        }


//        Behavior on gradient {
//            NumberAnimation { property: "rotation"; duration: 1000 }
//        }
        transform: Rotation {
            origin.x: parent.width / 2
            origin.y: parent.height / 2
            angle: 0
        }
    }
    Rectangle {
        id: rectmeter2
        y:0
        x:255
        width: 60
        height:400
        //anchors.bottom: parent.bottom
        radius:100
        //clip: true
        rotation:180
        gradient: Gradient {
            GradientStop { position: 0; color: "red" }
            GradientStop { position: 1 - speed / 30; color: "yellow" }
            GradientStop { position: 1 - speed / 30; color: "red" }
            GradientStop { position: 1; color: "green" }
        }
        NumberAnimation {
            target: rectmeter2
            property: "height"
            from:speedSlider.value>=21
            to:speedSlider.value<=30
            //to: parent.height * (1 - speed / 10)
            duration: 500
        }

//        Behavior on gradient {
//            NumberAnimation { property: "rotation"; duration: 1000 }
//        }
        transform: Rotation {
            origin.x: parent.width / 2
            origin.y: parent.height / 2
            angle: 0
        }
    }
    Rectangle {
        id: rectmeter1
        y: -125
        x: 130
        rotation: 90
        width: 60
        height: 315
        radius: height / 6
       // clip: true

        gradient: Gradient {
            GradientStop { position: 0.1; color: "green" }
            GradientStop { position: 1 - speed / 20; color: "yellow" }
            GradientStop { position: 1 - speed / 20; color: "red" }
            GradientStop { position: 1; color: "red" }
        }
        NumberAnimation {
            target: rectmeter1

            property: "height"
            from:speedSlider.value>=11
            to:speedSlider.value<=20
            //to:parent.height * (1 - speed / 10)
            duration: 500
        }


//        Behavior on gradient {
//            NumberAnimation { property: "rotation"; duration: 1000 }
//        }
        transform: Rotation {
            origin.x: parent.width / 2
            origin.y: parent.height / 2
            angle: 0
        }
    }


}


