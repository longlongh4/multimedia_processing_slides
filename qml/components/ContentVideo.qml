import QtQuick 2.1
import QtMultimedia 5.0

VideoOutput {
    source: mediaPlayer
    property alias mediaSource: mediaPlayer.source
    property alias volume: mediaPlayer.volume
    property bool isRunning: true

    MediaPlayer {
        id: mediaPlayer
        autoPlay: true
        volume: 0.5
        loops: Audio.Infinite
    }

    function play() { mediaPlayer.play() }
    function pause() { mediaPlayer.pause() }
    function stop() { mediaPlayer.stop() }

    function toggleplay() {
        if (isRunning) {
            pause()
            isRunning = false
        } else {
            play()
            isRunning = true
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: toggleplay()
    }
}
