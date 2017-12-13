import QtQuick 2.0

Effect {
    parameters: ListModel {
        ListElement {
            name: "DisplayMode"
            value: 1
        }
        onDataChanged: updateDisplayMode()
    }

    function updateDisplayMode()
    {
        displayMode = parameters.get(0).value
    }

    // Transform slider values, and bind result to shader uniforms
    property int displayMode: 1

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
        uniform int displayMode;
        uniform sampler2D source;
        uniform float dividerValue;
        uniform lowp float qt_Opacity;
        void main() {
            lowp vec4 rgba = texture2D(source, coord);
            lowp vec4 yuva = rgba;

            mat3 yuv2rgb = mat3(1.0, 0.0, 1.28033, 1.0, -0.21482, -0.38059, 1.0, 2.12798, 0.0);
            mat3 rgb2yuv = mat3(0.2126, 0.7152, 0.0722, -0.09991, -0.33609, 0.43600, 0.615, -0.5586, -0.05639);

            if (displayMode == 2) {
                yuva.y = 0.0;
                yuva.z = 0.0;
            } else if (displayMode == 3) {
                yuva.x = 0.0;
                yuva.z = 0.0;
            }  else if (displayMode == 4) {
                yuva.x = 0.0;
                yuva.y = 0.0;
            }  else if (displayMode > 4) {
                yuva.xyz = rgba.xyz * rgb2yuv;
                if (displayMode == 6) {
                    yuva.y = 0.0;
                    yuva.z = 0.0;
                } else if (displayMode == 7) {
                    yuva.z = 0.0;
                } else if (displayMode == 8) {
                    yuva.y = 0.0;
                } else if (displayMode == 9) {
                    yuva.x = 0.0;
                } else if (displayMode == 10) {
                    yuva.y = yuva.y / 2.0;
                    yuva.z = yuva.z / 2.0;
                }
                yuva.xyz = yuva.xyz * yuv2rgb;
            }

            if (coord.x < dividerValue)
                gl_FragColor = yuva * qt_Opacity;
            else
                gl_FragColor = qt_Opacity * texture2D(source, coord);

        }
    "
}
