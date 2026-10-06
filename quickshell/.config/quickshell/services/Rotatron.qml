pragma Singleton

//
// Screen rotation mode reported by `rotatron` (polybar rotate module),
// polled every second. `mode` stays empty when rotatron isn't installed.
//
import QtQuick
import Quickshell
import Quickshell.Io

import qs.services

Singleton {
    id: root

    property string mode: ""

    function set(): void {
        Commands.run("rotatron set");
        reader.running = true;
    }

    function toggle(): void {
        Commands.run("rotatron toggle");
        reader.running = true;
    }

    Process {
        id: reader

        command: ["sh", "-c", "command -v rotatron > /dev/null || exit 0; rotatron mode 2>&1"]
        running: true

        stdout: StdioCollector {
            // Like polybar, only the first line of output is shown.
            onStreamFinished: root.mode = text.trim().split("\n")[0]
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: reader.running = true
    }
}
