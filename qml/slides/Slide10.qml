import QtQuick 2.1
import QtMultimedia 5.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../templates"
import "../components"
import "../effects"

Slide {
    id: slide6
    title: "Video Container"

    ParallelAnimation{
        objectName: "animation1"
        ScriptAction { script: kickoffAnimation.start(); }
        NumberAnimation { target: img; property: "y"; to: 240; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: img; property: "height"; to: 540; easing.type: Easing.InOutQuad; duration: 400 }
        NumberAnimation { target: img; property: "width"; to: 960; easing.type: Easing.InOutQuad; duration: 400 }
    }

    ParallelAnimation{
        objectName: "animation2"
        NumberAnimation { target: videoTrack; property: "opacity"; to: 1.0; easing.type: Easing.InOutQuad; duration: 400 }
    }

    ParallelAnimation{
        objectName: "animation3"
        NumberAnimation { target: audioTrack; property: "opacity"; to: 1.0; easing.type: Easing.InOutQuad; duration: 400 }
    }

    ParallelAnimation{
        objectName: "animation4"
        NumberAnimation { target: subtitleStream; property: "opacity"; to: 1.0; easing.type: Easing.InOutQuad; duration: 400 }
    }


    ShaderEffectSource {
        id: theSource
        smooth: true
        hideSource: true
        sourceItem: img
        anchors.fill: img
        visible: false
    }

    ContentVideo {
        id: img
        fillMode: Image.PreserveAspectFit
        width: 1280
        visible: false
        mediaSource: "qrc:/images/hobbit.mp4"
        anchors.centerIn: parent
    }

    SequentialAnimation {
        id: kickoffAnimation
        loops: 1

        // setup
        PropertyAction { target: rotationAnimation; property: "running"; value: false }
        PropertyAction { target: timeAnimation; property: "running"; value: false }
        PropertyAction { target: shader; property: "amp"; value: 0 }
        PropertyAction { target: shader; property: "xrot"; value: 0 }
        PropertyAction { target: shader; property: "zrot"; value: 0 }
        PropertyAction { target: shader; property: "time"; value: 0 }
        PropertyAction { target: shader; property: "scale"; value: 1; }
        PropertyAction { target: rotationAnimation; property: "running"; value: false }
        PropertyAction { target: timeAnimation; property: "running"; value: false }
        // short pause
        PauseAnimation { duration: 2000 }
        // get started...
        ParallelAnimation {
            NumberAnimation { target: shader; property: "xrot"; to: 2 * Math.PI / 8; duration: 1000; easing.type: Easing.InOutCubic }
            NumberAnimation { target: shader; property: "amp"; to: 0.1; duration: 1000; easing.type: Easing.InOutCubic }
//            NumberAnimation { target: shader; property: "scale"; to: 1.5; duration: 1000; easing.type: Easing.InOutCubic }
            PropertyAction { target: rotationAnimation; property: "running"; value: true }
            PropertyAction { target: timeAnimation; property: "running"; value: true }
        }
    }


    ShaderEffect {
        id: shader
        anchors.fill: img

        blending: true

        mesh: "50x50"

        property variant size: Qt.size(width, height);

        property variant source: theSource;

        property real amp: 0

        property real xrot: 0; // 2 * Math.PI / 8;
//        NumberAnimation on xrot { from: 0; to: Math.PI * 2; duration: 3000; loops: Animation.Infinite }

        property real zrot: 0
        NumberAnimation on zrot {
            id: rotationAnimation
            from: 0;
            to: Math.PI * 2;
            duration: 20000;
            loops: 1
            easing.type: Easing.InOutCubic
            running: false;
        }

        property real time: 0
        NumberAnimation on time {
            id: timeAnimation
            from: 0;
            to: Math.PI * 2;
            duration: 3457;
            loops: Animation.Infinite
            running: false;
        }

        vertexShader: "
        attribute highp vec4 qt_Vertex;
        attribute highp vec2 qt_MultiTexCoord0;
        uniform highp mat4 qt_Matrix;
        uniform highp float xrot;
        uniform highp float zrot;
        uniform highp vec2 size;
        uniform highp float time;
        uniform highp float amp;
        varying lowp vec2 v_TexCoord;
        varying lowp float v_light;
        void main() {
            highp float xcosa = cos(xrot);
            highp float xsina = sin(xrot);

            highp mat4 xrot = mat4(1, 0, 0, 0,
                                   0, xcosa, xsina, 0,
                                   0, -xsina, xcosa, 0,
                                   0, 0, 0, 1);

            highp float zcosa = cos(zrot);
            highp float zsina = sin(zrot);

            highp mat4 zrot = mat4(zcosa, zsina, 0, 0,
                                   -zsina, zcosa, 0, 0,
                                   0, 0, 1, 0,
                                   0, 0, 0, 1);

            highp float near = 2.;
            highp float far = 6.;
            highp float fmn = far - near;

            highp mat4 proj = mat4(near, 0, 0, 0,
                                   0, near, 0, 0,
                                   0, 0, -(far + near) / fmn, -1.,
                                   0, 0, -2. * far * near / fmn, 1);

            highp mat4 model = mat4(2, 0, 0, 0,
                                    0, 2, 0, 0,
                                    0, 0, 2, 0,
                                    0, -.5, -4, 1);

            vec4 nLocPos = vec4(qt_Vertex.xy * 2.0 / size - 1.0, 0, 1);
            nLocPos.z = cos(nLocPos.x * 5. + time) * amp;

            vec4 pos = proj * model * xrot * zrot * nLocPos;
            pos = vec4(pos.xyx/pos.w, 1);

            gl_Position = qt_Matrix * vec4((pos.xy + 1.0) / 2.0 * size , 0, 1);

            v_TexCoord = qt_MultiTexCoord0;


            v_light = dot(normalize(vec3(-sin(nLocPos.x * 5.0 + time) * 5.0 * amp, 0, -1)), vec3(0, 0, -1));
        }
        "

        fragmentShader: "
            uniform lowp sampler2D source;
            uniform lowp float qt_Opacity;
            varying highp vec2 v_TexCoord;
            varying lowp float v_light;
            void main() {
                highp vec4 c = texture2D(source, v_TexCoord);
                gl_FragColor = (vec4(pow(v_light, 16.0)) * 0.3 + c) * qt_Opacity;
            }
        "

    }

    Text {
        id: videoTrack
        x: 80
        y: 80
        opacity: 0
        wrapMode: Text.WordWrap
        font.family: "Courier"
        font.pixelSize: 34
        color: "black"
        text: "Video Stream"
    }

    Text {
        id: audioTrack
        anchors.right: parent.right
        anchors.rightMargin: 80
        y: 80
        opacity: 0
        wrapMode: Text.WordWrap
        font.family: "Courier"
        font.pixelSize: 34
        color: "black"
        text: "Audio Stream"
    }

    Text {
        id: subtitleStream
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 0
        wrapMode: Text.WordWrap
        font.family: "Courier"
        font.pixelSize: 34
        color: "black"
        text: "Subtitle Stream"
    }
}
