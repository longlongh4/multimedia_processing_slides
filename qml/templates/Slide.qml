import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    property string title: ""
    property alias content: container.sourceComponent
    property int currentStateIndex: 0

    Text {
        id: titleItem
        text: title
        font.bold: true
        font.pointSize: 30
    }

    Rectangle{
        id: horizontalLineItem
        anchors.top: titleItem.bottom
        anchors.topMargin: 2
        width: parent.width
        height: 1
        color: "darkgrey"
    }

    Loader {
        id: container
        width: parent.width
        anchors.topMargin: 4
        anchors.top: horizontalLineItem.bottom
        anchors.bottom: parent.bottom
    }

    //return -1 if all state has been displayed
    //return 0 if change state successfully
    function nextState() {
        var statesLength = container.item.states.length
        if (currentStateIndex < statesLength) {
            currentStateIndex++
            container.item.state = "" + currentStateIndex
            return 0
        }
        return -1

    }
}
