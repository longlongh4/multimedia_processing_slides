import QtQuick 2.1
import QtMultimedia 5.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../templates"
import "../components"
import "../effects"
import QtQuick.Particles 2.0

Slide {
    id: slide11
    title: "Thank you"
    Item {
        width: 500
        height: 500
        anchors.horizontalCenter: parent.horizontalCenter
        y: 50
        ParticleSystem {
            width: 500
            height: 500
            anchors.centerIn: parent

            ImageParticle {
                source: "qrc:/images/particle.png"
                z: 2
                anchors.fill: parent
                color: "blue"
                alpha: 1
                colorVariation: 0.5
            }

            Emitter {
                anchors.fill: parent
                emitRate: 9000
                lifeSpan: 720
                size: 10
                //! [0]
                shape: MaskShape {
                    source: "qrc:/images/starfish_mask.png"
                }
                //! [0]
            }
        }
    }

    Text {
        id: others
        anchors.horizontalCenter: parent.horizontalCenter
        y: 600
        font.family: "Courier"
        font.pointSize: 100
        font.bold: true
        color: "black"
        text: "Hailong"
    }
}
