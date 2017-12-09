import QtQuick 2.0
import "./templates"

Item {
    width: 1440
    height: 900

    signal nextSlide()
    signal previousSlide()

    property int currentSlideIndex: 1
    property int slidesCount: 2

    onNextSlide: currentSlideIndex >= slidesCount ? currentSlideIndex = currentSlideIndex : currentSlideIndex = currentSlideIndex + 1
    onPreviousSlide: currentSlideIndex <= 1 ? currentSlideIndex = currentSlideIndex : currentSlideIndex = currentSlideIndex - 1

    Rectangle{
        id: background
        anchors.fill: parent
        color: "white"
    }

    Loader{
        anchors.fill: parent
        anchors.margins: 40
        source: "./slides/Slide"+ currentSlideIndex +".qml"
    }
}
