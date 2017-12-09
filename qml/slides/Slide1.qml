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
        target: Image {
            width: 800
            onWidthChanged: mountain.height = width / sourceSize.width * sourceSize.height
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/mountain.jpg"
        }
    }

    HoverScale{
        id: ccd
        x: 430
        y: 20
        opacity: 0
        target: Image {
            width: 400
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/ccd.jpg"
        }
    }

    HoverScale{
        id: ycrcb
        x: 860
        y: 10
        opacity: 0
        target: Image {
            width: 360
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/ycrcb.jpg"
        }
    }
}
