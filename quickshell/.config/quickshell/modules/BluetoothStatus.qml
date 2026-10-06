//
// Bluetooth power state (polybar bluetooth module). Hidden when there is no
// adapter. Left click toggles power, right click opens bluetui.
//
// polybar renders this label with font T7 (Feather), which only has the
// space glyph, so spaces come from Feather and everything else falls back to
// JetBrains Mono. The segments below reproduce that mix.
//
import QtQuick
import Quickshell.Bluetooth

import qs.components
import qs.config
import qs.services

Item {
    id: root

    property real fontSize: 13

    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    readonly property bool powered: adapter?.enabled ?? false
    readonly property var segments: [" ", "", " ", powered ? "on" : "off", " "]

    visible: adapter !== null
    implicitWidth: content.implicitWidth
    height: parent.height

    Row {
        id: content

        height: parent.height

        Repeater {
            model: root.segments

            delegate: BarText {
                required property string modelData

                fontSize: modelData === " " ? root.fontSize * 1.04 : root.fontSize
                font.family: modelData === " " ? "Feather" : Theme.fontFamily
                text: modelData
                color: root.powered ? Theme.psec : Theme.gray
            }
        }
    }

    ClickArea {
        leftAction: () => {
            if (root.adapter)
                root.adapter.enabled = !root.adapter.enabled;
        }
        rightAction: () => Commands.popupRun("bluetui")
    }
}
