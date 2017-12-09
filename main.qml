import QtQuick 2.9
import QtQuick.Window 2.2

import "qml"

Window {
    id: window
    visible: true
    width: 1440
    height: 900
    flags: Qt.WindowFullscreenButtonHint
    title: qsTr("MultiMedia Processing")
    Presentation{
        id: presentation
        anchors.centerIn: parent
    }

    onWidthChanged: {
        resizePresentation()
    }

    onHeightChanged: {
        resizePresentation()
    }

    function resizePresentation() {
        var winWidth = window.width
        var winHeight = window.height
        var ratioHeight = winWidth / 1440.0 * 900
        if (winHeight >= ratioHeight) {
            presentation.scale = ratioHeight / 900.0
        }else {
            presentation.scale = winHeight / 900.0
        }
    }
}
