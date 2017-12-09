import QtQuick 2.0
import "../templates"

Slide {
    title: "First Slide"
    content: Item{
        Image {
            id: mountain
            width: 800
            x: (parent.width - 800) / 2
            y: 100
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/mountain.jpg"
        }
    }
}
