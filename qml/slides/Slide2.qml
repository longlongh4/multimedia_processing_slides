import QtQuick 2.1
import QtMultimedia 5.0
import QtQuick.Controls 2.3
import "../templates"
import "../components"
import "../effects"

Slide {
    title: "Second Slide"

    ShaderEffectSource {
        id: theSource
        smooth: true
        hideSource: true
        sourceItem: camera
        width: camera.width
        height: camera.height
    }

    ContentCamera{
        id: camera
    }

    Billboard{
        id: effect
        targetHeight: camera.height
        targetWidth: camera.width
        source: theSource
        anchors.fill: camera
    }

    Slider {
        anchors {
            left: theSource.left
            right: theSource.right
            top: theSource.bottom
            topMargin: 10
        }
        visible: camera.cameraStatus === Camera.ActiveStatus

        onValueChanged: effect.dividerValue = value

        from: 0.0
        value: 0.5
        to: 1.0
    }
}
