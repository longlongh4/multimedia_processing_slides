import QtQuick 2.0
import "../templates"
import "../components"

Slide {
    title: "First Slide"
    content: Item{
        HoverScale{
            x: (parent.width - 800) / 2
            y: 100
            id: mountain
            target: Image {
                width: 800
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/mountain.jpg"
            }
        }
    }
}
