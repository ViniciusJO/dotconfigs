//
// Screen rotation mode (polybar rotate module): " A " inverted while in
// automatic mode, " M " in manual mode. Left click runs `rotatron set`,
// right click `rotatron toggle`.
//
import QtQuick

import qs.components
import qs.config
import qs.services

Rectangle {
    id: root

    property real fontSize: 13
    readonly property bool automatic: Rotatron.mode === "AUTOMATIC"
    readonly property bool manual: Rotatron.mode === "MANUAL"

    visible: Rotatron.mode !== ""
    width: label.implicitWidth
    height: parent.height
    color: automatic ? Theme.pcont : manual ? Theme.black : "transparent"

    BarText {
        id: label

        fontSize: root.fontSize
        text: root.automatic ? " A " : root.manual ? " M " : Rotatron.mode
        color: root.automatic ? Theme.black : root.manual ? Theme.pcont : Theme.fg
    }

    ClickArea {
        leftAction: () => Rotatron.set()
        rightAction: () => Rotatron.toggle()
    }

    // TapHandler {
    //     id: tapHandler
    //
    //     acceptedButtons: Qt.LeftButton | Qt.RightButton
    //
    //     onPressedChanged: {
    //         if (pressed)
    //             component.longPressTriggered = false
    //     }
    //
    //     onLongPressed: {
    //         component.longPressTriggered = true
    //         component.rightClicked()
    //     }
    //
    //     onTapped: (eventPoint, button) => {
    //         if (button === Qt.RightButton) {
    //             if (!component.longPressTriggered)
    //               Rotatron.set();
    //                 // component.rightClicked()
    //         } else if (!component.longPressTriggered) {
    //               Rotatron.toggle();
    //               // component.leftClicked()
    //         }
    //     }
    // }
}
