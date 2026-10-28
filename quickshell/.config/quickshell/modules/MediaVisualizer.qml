import QtQuick
import Quickshell.Io

import qs.config

Item {
    id: root

    required property int bars_width
    required property int bars_spacing
    required property int bars_radius

    property int barCount: 15
    property var levels: Array(root.barCount).fill(0)

    width: root.barCount * 3 - 1
    height: parent.height

    Process {
        command: [
            "sh", "-c",
            "printf '%s\\n' '[general]' 'bars = " + root.barCount + "' 'framerate = 30' '[input]' 'method = pipewire' 'source = auto' '[output]' 'method = raw' 'channels = mono' 'raw_target = /dev/stdout' 'data_format = ascii' 'ascii_max_range = 98' 'bar_delimiter = 59' 'frame_delimiter = 10' | cava -p /dev/stdin"
        ]
        running: true

        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                const values = data.trim().split(";").filter(value => value !== "");
                if (values.length < root.barCount)
                    return;
                root.levels = values.slice(0, root.barCount)
                    .map(value => Math.max(0, Math.min(1, Number(value) / 100)));
            }
        }
    }

    Row {
        anchors.centerIn: parent
        spacing: root.bars_spacing

        Repeater {
            model: root.barCount

            Rectangle {
                required property int index
                width: root.bars_width
                height: Math.max(2, root.levels[index] * 24)
                radius: root.bars_radius
                color: Theme.pprim
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
