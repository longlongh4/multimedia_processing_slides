import QtQuick 2.1
import QtMultimedia 5.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../templates"
import "../components"
import "../effects"

Slide {
    id: slide2
    title: "Why Use YUV"

    property string effectItem: "yuv"

    ParallelAnimation{
        objectName: "animation1"
        NumberAnimation { target: camera; property: "x"; to: 0; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: camera; property: "width"; to: 960; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: camera; property: "height"; to: 540; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: radioGroup; property: "x"; to: 1120; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: radioGroup; property: "opacity"; to: 1.0; easing.type: Easing.InOutQuad; duration: 400 }
    }

    ParallelAnimation{
        objectName: "animation2"
        NumberAnimation { target: camera; property: "x"; to: 40; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: camera; property: "width"; to: 1280; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: camera; property: "height"; to: 720; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: radioGroup; property: "x"; to: 1360; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: radioGroup; property: "opacity"; to: 0.0; easing.type: Easing.InOutQuad; duration: 400 }
        PropertyAction { target: effect; property: "displayMode"; value: 1 }
    }

    SequentialAnimation{
        objectName: "animation3"
        PropertyAction { target: billboardEffect; property: "opacity"; value: 0.1 }
        ParallelAnimation{
            PropertyAction { target: slide2; property: "effectItem"; value: "billboard" }
            NumberAnimation { target: billboardEffect; property: "opacity"; to: 1.0; easing.type: Easing.InOutQuad; duration: 400 }
        }
    }

    ParallelAnimation{
        objectName: "animation4"
        NumberAnimation { target: calculater; property: "opacity"; to: 1.0; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: calculater; property: "y"; to: 10; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: camera; property: "x"; to: 200; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: camera; property: "y"; to: 200; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: camera; property: "width"; to: 960; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: camera; property: "height"; to: 540; easing.type: Easing.InOutQuad; duration: 400 }
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
            Rectangle{
                width: parent.width
                height: 2
                color: "black"
            }
            RadioButton {
                text: "YUV"
                onCheckedChanged: if(checked) {effect.displayMode = 5}
            }
            RadioButton {
                text: "Y Only"
                onCheckedChanged: if(checked) {effect.displayMode = 6}
            }
            RadioButton {
                text: "Y + U"
                onCheckedChanged: if(checked) {effect.displayMode = 7}
            }
            RadioButton {
                text: "Y + V"
                onCheckedChanged: if(checked) {effect.displayMode = 8}
            }
            RadioButton {
                text: "U + V"
                onCheckedChanged: if(checked) {effect.displayMode = 9}
            }
            RadioButton {
                text: "Y + (U + V) / 2"
                onCheckedChanged: if(checked) {effect.displayMode = 10}
            }
        }
    }

    onEffectItemChanged: {
        if (effectItem === "billboard") {
            effect.source = undefined
            effect.visible = false
            billboardEffect.source = theSource
        }
    }

    Billboard{
        id: billboardEffect
        opacity: 0
        targetHeight: camera.height
        targetWidth: camera.width
        anchors.fill: camera
    }

    RowLayout {
        id: calculater
        opacity: 0
        spacing: 20
        y: -40
        height: 40
        TextEditWithStar{
            id: edit
            width: 800
            height: 40
            onTextChanged: valueItem.setValue(eval(text))
        }

        Text {
            text: "="
            font.family: "Courier"
            font.pixelSize: 28
            color: "black"
        }
        Text {
            id: valueItem
            width: 200
            text: ""
            font.family: "Courier"
            font.pixelSize: 28
            color: "black"
            function setValue(textValue) {
                if (textValue % 1 === 0) {
                    if(textValue > 1000000000)
                    {
                        textValue /= 1000000000
                        textValue += "GB"
                    }else if(textValue > 1000000) {
                        textValue /= 1000000
                        textValue += "MB"
                    }
                    else if(textValue > 1000) {
                        textValue /= 1000
                        textValue += "KB"
                    }

                    text = textValue
                }else {
                    text = "I can't understand!"
                }
            }
        }
    }

    Slider {
        id: sliderItem
        anchors {
            left: theSource.left
            right: theSource.right
            top: theSource.bottom
            topMargin: 10
        }

        onValueChanged: { effect.dividerValue = value ; billboardEffect.dividerValue = value }

        from: 0.0
        value: 0.5
        to: 1.0
    }
}
