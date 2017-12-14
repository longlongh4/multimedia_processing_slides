import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: container

    property alias text: textEdit.text

    border.color: "black"
    border.width: 1
    radius: 10
    TextEdit {
        id: textEdit
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        focus: true
        font.family: "Courier"
        font.pixelSize: 28
        color: "black"
        onCursorRectangleChanged: {
            cursorItem.x = cursorRectangle.x
            if(text!=="") {
                emitter.burst(2)
            }
        }

        Item{
            id: cursorItem
            width: 1
            height: 1
            y: 20
            ParticleSystem{
                id: particleSystem
            }

            Emitter {
                id: emitter
                anchors.centerIn: parent
                width: 1
                height: 1
                system: particleSystem
                emitRate: 0
                lifeSpan: 700
                lifeSpanVariation: 300
                size: 8
                endSize: 16
                velocity: AngleDirection{
                    angle: 90
                    angleVariation: 150
                    magnitude: 30
                }
            }

            Gravity {
                system: particleSystem
                magnitude: 100
                angle: 90
            }

            ImageParticle{
                source: "qrc:/images/star.png"
                system: particleSystem
                rotationVariation: 10
            }
        }
    }
}
