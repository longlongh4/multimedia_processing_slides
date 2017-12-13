import QtQuick 2.1
import QtMultimedia 5.8

VideoOutput {
    source: camera

    Camera {
        id: camera
    }
}
