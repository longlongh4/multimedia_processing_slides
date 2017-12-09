import QtQuick 2.0
import "./templates"

Item {
    width: 1440
    height: 900

    ListModel{
        id: slidesList

    }

    Rectangle{
        id: background
        anchors.fill: parent
        color: "white"
    }

    Slide {
        id: slide
        anchors.fill: parent
        title: "First Slide"
    }
}
