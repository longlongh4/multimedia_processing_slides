import QtQuick 2.1
import QtMultimedia 5.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../templates"
import "../components"
import "../effects"

Slide {
    id: slide8
    title: "Compress Video Three"

    Image {
        id: img
        fillMode: Image.PreserveAspectFit
        width: 1280
        source: "qrc:/images/3.png"
        anchors.centerIn: parent
    }
}
