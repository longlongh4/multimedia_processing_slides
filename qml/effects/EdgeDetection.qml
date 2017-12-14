import QtQuick 2.0

Effect {
    parameters: ListModel {
        ListElement {
            name: "Threshold"
            value: 0.0
        }
        onDataChanged: updateMixLevel()
    }

    function updateMixLevel()
    {
        mixLevel = parameters.get(0).value;
    }

    Component.onCompleted: dividerValue = 1.0

    // Transform slider values, and bind result to shader uniforms
    property real mixLevel: 0.0
    property real targetSize: 250 - (200 * mixLevel) // TODO: fix ...
    property real resS: targetSize
    property real resT: targetSize

    fragmentShaderFilename: "sobeledgedetection.fsh"
}
