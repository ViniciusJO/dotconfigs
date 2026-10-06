pragma Singleton

//
// Battery status (polybar battery_custom module, scripts/battery.sh).
//
// Reads the first BAT* device in /sys/class/power_supply every 5 seconds.
//
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string devicePath: ""
    property string status: ""
    property int capacity: 0

    readonly property bool available: devicePath !== ""
    readonly property bool charging: status === "Charging"
    readonly property bool full: capacity >= 99

    Process {
        command: ["sh", "-c", "ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -n 1"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.devicePath = text.trim()
        }
    }

    FileView {
        id: statusFile

        path: root.devicePath ? root.devicePath + "/status" : ""
        printErrors: false
        onLoaded: root.status = text().trim()
    }

    FileView {
        id: capacityFile

        path: root.devicePath ? root.devicePath + "/capacity" : ""
        printErrors: false
        onLoaded: root.capacity = parseInt(text()) || 0
    }

    Timer {
        interval: 5000
        running: root.available
        repeat: true
        onTriggered: {
            statusFile.reload();
            capacityFile.reload();
        }
    }
}
