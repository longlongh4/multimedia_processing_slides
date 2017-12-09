import QtQuick 2.0
import "../templates"
import "../components"

Slide {
    title: "First Slide"

    ParallelAnimation{
        objectName: "animation1"
        NumberAnimation { target: mountain; property: "x"; to: 100; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: mountain; property: "y"; to: 40; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: mountain; property: "width"; to: 300; easing.type: Easing.InOutQuad; duration: 400 }
    }

    ParallelAnimation{
        objectName: "animation2"
        NumberAnimation { target: ccd; property: "opacity"; to: 1; easing.type: Easing.InOutQuad; duration: 400 }
    }

    ParallelAnimation{
        objectName: "animation3"
        NumberAnimation { target: ycrcb; property: "opacity"; to: 1; easing.type: Easing.InOutQuad; duration: 400 }
    }

    HoverScale{
        id: mountain
        x: (parent.width - 800) / 2
        y: 100
        width: 800
        Image {
            onWidthChanged: mountain.height = width / sourceSize.width * sourceSize.height
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
            source: "qrc:/images/mountain.jpg"
            onStatusChanged: if (status == Image.Ready) {
                                 parent.height = parent.width/sourceSize.width*sourceSize.height
                             }
        }
    }

    HoverScale{
        id: ccd
        x: 430
        y: 20
        width: 400
        opacity: 0
        Image {
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/ccd.jpg"
            anchors.fill: parent
            onStatusChanged: if (status == Image.Ready) {
                                 parent.height = parent.width/sourceSize.width*sourceSize.height
                             }
        }
    }

    HoverScale{
        id: ycrcb
        x: 860
        y: 10
        opacity: 0
        width: 360
        Image {
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/ycrcb.jpg"
            anchors.fill: parent
            onStatusChanged: if (status == Image.Ready) {
                                 parent.height = parent.width/sourceSize.width*sourceSize.height
                             }
        }
    }
}
