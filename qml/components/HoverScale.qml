import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: container
    property alias target: loaderItem.sourceComponent
    property alias targetItem: loaderItem.item

    onWidthChanged: loaderItem.item.width = width
    onHeightChanged: loaderItem.item.height = height

    MouseArea{
        id: mouseAreaItem
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true

        onClicked: mouse.accepted = false;
        onPressed: mouse.accepted = false;
        onReleased: mouse.accepted = false;
        onDoubleClicked: mouse.accepted = false;
        onPositionChanged: mouse.accepted = false;
        onPressAndHold: mouse.accepted = false;

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
        cornerRadius: glowRadius
    }

    Loader{
        id: loaderItem
        onLoaded: {
            container.width = loaderItem.item.width
            container.height = loaderItem.item.height
        }
    }
}
