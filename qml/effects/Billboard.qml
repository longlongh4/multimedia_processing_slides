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

    fragmentShaderFilename: "billboard.fsh"
}
