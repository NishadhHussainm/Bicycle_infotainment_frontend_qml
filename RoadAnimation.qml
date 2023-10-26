import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {
    width: 500
    height: 300

    //    PathView {
    //        id: pathView
    //        model: 50
    //        delegate: Rectangle {
    //            width: 1
    //            height: 1
    //            color: "white"
    //        }

    //        path: Path {
    //            id: roadPath
    //            startX: 45
    //            startY: 210


    //            PathQuad { controlX: 70; controlY: 160; x: 90; y: 210 }
    //            PathQuad { controlX: 90; controlY: 220; x: 110; y: 200 }
    //            PathQuad { controlX: 130; controlY: 160; x: 150; y: 200 }
    //            PathQuad { controlX: 160; controlY: 220; x: 170; y: 200 }

    //        }
    //    }

    Image {
        id: cycle
        width: 25
        height: 25
        source: "cycle"

        x:1000;y:200

//        PathAnimation {
//            id: cycleAnimation
//            target: cycle
//            path: roadPath
//            duration: 10000
//           // easing.type: "InOutCirc"
//            loops: Animation.Infinite
//            running: window.speed > 0
//           }
    }
}
