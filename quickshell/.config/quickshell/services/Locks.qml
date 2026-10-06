pragma Singleton

//
// Caps Lock / Num Lock state (polybar caps / num modules).
//
// Read from the kernel LED nodes of the keyboard (`/sys/class/leds/*::capslock`
// and `*::numlock`), which X keeps in sync with its own lock state. Polled
// every 0.5s like the original `cns.sh` script, but without spawning `xset`.
//
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool capsLock: false
    property bool numLock: false

    property string capsPath: ""
    property string numPath: ""

    Process {
        command: ["sh", "-c", "ls -d /sys/class/leds/*::capslock /sys/class/leds/*::numlock 2>/dev/null"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.trim().split("\n").filter(line => line);
                root.capsPath = lines.find(line => line.endsWith("::capslock")) ?? "";
                root.numPath = lines.find(line => line.endsWith("::numlock")) ?? "";
            }
        }
    }

    FileView {
        id: capsFile

        path: root.capsPath ? root.capsPath + "/brightness" : ""
        printErrors: false
        onLoaded: root.capsLock = text().trim() !== "0"
    }

    FileView {
        id: numFile

        path: root.numPath ? root.numPath + "/brightness" : ""
        printErrors: false
        onLoaded: root.numLock = text().trim() !== "0"
    }

    Timer {
        interval: 500
        running: root.capsPath !== "" || root.numPath !== ""
        repeat: true
        onTriggered: {
            capsFile.reload();
            numFile.reload();
        }
    }
}
