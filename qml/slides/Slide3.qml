import QtQuick 2.1
import QtMultimedia 5.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../templates"
import "../components"
import "../effects"

Slide {
    id: slide3
    title: "YUV420"

    ParallelAnimation{
        objectName: "animation1"
        NumberAnimation { target: others; property: "opacity"; to: 1.0; easing.type: Easing.InOutQuad; duration: 400 }
    }

    Image{
        source: "qrc:/images/yuv420.jpg"
        fillMode: Image.PreserveAspectFit
        scale: 1.5
        width: 1280
        anchors.centerIn: parent
    }

    Text {
        id: others
        width: parent.width - 160
        x: 80
        y: 680
        opacity: 0
        wrapMode: Text.WordWrap
        font.family: "Courier"
        font.pixelSize: 28
        color: "black"
        text: "Others: YUY2、YUYV、YVYU、UYVY、AYUV、Y41P、Y411、Y211、IF09、IYUV、YV12、YVU9、YUV411、YUV420"
    }
}
