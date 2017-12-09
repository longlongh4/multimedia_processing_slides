import QtQuick 2.0
import "../templates"
import "../components"

Slide {
    title: "First Slide"

    content: Item{

        states: [
            State {
                name: "1"
                PropertyChanges {
                    target: mountain
                    x: 40
                    y: 40
                    width: 100

                }
            }
        ]

        HoverScale{
            id: mountain
            x: (parent.width - 800) / 2
            y: 100
            target: Image {
                width: 800
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/mountain.jpg"
            }
        }
    }
}
