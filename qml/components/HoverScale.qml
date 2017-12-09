import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: container
    property alias target: loaderItem.sourceComponent
    width: loaderItem.width
    height: loaderItem.height

    MouseArea{
        id: mouseAreaItem
        anchors.fill: parent
        hoverEnabled: true

        onContainsMouseChanged: containsMouse ? container.state = "hover" : container.state = ""
    }

    states: [
        State {
            name: "hover"
            PropertyChanges { target: effect; opacity: 1.0 }
            PropertyChanges { target: container; scale: 1.05 }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "opacity"; easing.type: Easing.InOutQuad; duration: 200 }
        NumberAnimation { properties: "scale"; easing.type: Easing.InOutQuad; duration: 200 }
    }


    RectangularGlow {
        id: effect
        anchors.fill: parent
        opacity: 0.0
        glowRadius: 4
        spread: 0.2
        color: "green"
        cornerRadius: 10 + glowRadius
    }

    Loader{
        id: loaderItem
    }
}
