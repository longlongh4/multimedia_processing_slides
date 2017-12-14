import QtQuick 2.1
import QtMultimedia 5.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../templates"
import "../components"
import "../effects"

Slide {
    id: slide4
    title: "Forth Slide"

    ShaderEffectSource {
        id: theSource
        smooth: true
        hideSource: false
        sourceItem: img
        anchors.fill: img
    }

    EdgeDetection{
        id: effect
        targetHeight: img.height
        targetWidth: img.width
        source: theSource
        anchors.fill: img
    }

    ContentImage{
        id: img
        width: 1280
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        z: 5
        opacity: 1.0
        source: "qrc:/images/witcher3.jpg"
    }

    Slider {
        id: sliderItem
        anchors {
            left: theSource.left
            right: theSource.right
            top: theSource.bottom
            topMargin: 10
        }

        onValueChanged: { img.opacity = (1.0-value) }

        from: 0.0
        value: 0.0
        to: 1.0
    }
}
