//
// Clock (polybar date module). Left click toggles the long format, right
// click opens calcurse.
//
import QtQuick
import Quickshell

import qs.components
import qs.config
import qs.services

Item {
    id: root

    property real fontSize: 13
    property bool alternate: false

    // polybar formats dates with the classic "C" locale.
    readonly property var locale: Qt.locale("C")

    implicitWidth: content.implicitWidth
    height: parent.height

    SystemClock {
        id: clock

        precision: root.alternate ? SystemClock.Seconds : SystemClock.Minutes
    }

    Row {
        id: content

        height: parent.height

        BarText {
            visible: root.alternate
            fontSize: root.fontSize
            text: ""
            color: Theme.pcont
        }

        BarText {
            fontSize: root.fontSize
            medium: true
            color: Theme.pcont
            text: root.alternate
                ? root.locale.toString(clock.date, "HH:mm:ss dd/MM/yyyy")
                : root.locale.toString(clock.date, "HH:mm")
        }
    }

    ClickArea {
        leftAction: () => root.alternate = !root.alternate
        rightAction: () => Commands.popupRun("calcurse")
    }
}
