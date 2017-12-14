import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    width: 360
    height: 600
    color: "black"

    MouseArea{
        anchors.fill: parent
        onClicked: {
            emitter.burst(10)
        }
    }

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
        size: 16
        endSize: 32
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
        source: "qrc:/images/blueStar.png"
        color: "blue"
        colorVariation: 1.0
        system: particleSystem
        rotationVariation: 10
    }
}
