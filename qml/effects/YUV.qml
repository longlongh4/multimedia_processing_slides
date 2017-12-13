import QtQuick 2.0

Effect {
    parameters: ListModel {
        ListElement {
            name: "Grid Spacing"
            value: 0.5
        }
        onDataChanged: updateGrid()
    }

    function updateGrid()
    {
            grid = parameters.get(0).value * 10;
    }

    // Transform slider values, and bind result to shader uniforms
    property real grid: 5.0

    property real step_x: 0.0015625
    property real step_y: targetHeight ? (step_x * targetWidth / targetHeight) : 0.0

    vertexShader: "
                    uniform highp mat4 qt_Matrix;
                    attribute highp vec4 qt_Vertex;
                    attribute highp vec2 qt_MultiTexCoord0;
                    varying highp vec2 coord;
                    void main() {
                        coord = qt_MultiTexCoord0;
                        gl_Position = qt_Matrix * qt_Vertex;
                    }"

    fragmentShader: "
        varying highp vec2 coord;
        uniform sampler2D source;
        uniform lowp float qt_Opacity;
        void main() {
            lowp vec4 rgba = texture2D(source, coord);
            lowp vec4 yuva = vec4(0.0);

            yuva.x = 0.0;
            yuva.y = rgba.g;
            yuva.z = 0.0;
            yuva.w = 1.0;

            gl_FragColor = yuva * qt_Opacity;
        }
    "
}
