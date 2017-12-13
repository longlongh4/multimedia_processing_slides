import QtQuick 2.1
import QtMultimedia 5.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../templates"
import "../components"
import "../effects"

Slide {
    title: "Second Slide"

    ParallelAnimation{
        objectName: "animation1"
        NumberAnimation { target: camera; property: "x"; to: 0; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: camera; property: "width"; to: 960; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: camera; property: "height"; to: 540; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: radioGroup; property: "x"; to: 1120; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: radioGroup; property: "opacity"; to: 1.0; easing.type: Easing.InOutQuad; duration: 400 }
    }

    ShaderEffectSource {
        id: theSource
        smooth: true
        hideSource: true
        sourceItem: camera
        anchors.fill: camera
    }

    ContentCamera{
        id: camera
        width: 1280
        height: 720
        anchors.verticalCenter: parent.verticalCenter
        x: 40
    }

    YUV{
        id: effect
        targetHeight: camera.height
        targetWidth: camera.width
        source: theSource
        anchors.fill: camera
    }

    GroupBox {
        id: radioGroup
        title: "Display Mode"
        width: 240
        x: 1360
        opacity: 0
        ColumnLayout {
            anchors.fill: parent
            RadioButton {
                checked: true
                text: "RGB"
                onCheckedChanged: if(checked) {effect.displayMode = 1}
            }
            RadioButton {
                text: "R Only"
                onCheckedChanged: if(checked) {effect.displayMode = 2}
            }
            RadioButton {
                text: "G Only"
                onCheckedChanged: if(checked) {effect.displayMode = 3}
            }
            RadioButton {
                text: "B Only"
                onCheckedChanged: if(checked) {effect.displayMode = 4}
            }
        }
    }

    //    Billboard{
    //        id: effect
    //        targetHeight: camera.height
    //        targetWidth: camera.width
    //        source: theSource
    //        anchors.fill: camera
    //    }

    Slider {
        anchors {
            left: theSource.left
            right: theSource.right
            top: theSource.bottom
            topMargin: 10
        }

        onValueChanged: effect.dividerValue = value

        from: 0.0
        value: 0.5
        to: 1.0
    }
}
