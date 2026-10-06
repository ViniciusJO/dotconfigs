pragma Singleton

//
// Screen brightness (polybar backlight module).
//
// Reads the first /sys/class/backlight device (the same one `brightnessctl`
// picks by default). sysfs brightness files don't emit change events, so the
// value is polled; changes go through ~/.scripts/brightness/changeBrightness.sh
// to keep its stepping rules.
//
import QtQuick
import Quickshell
import Quickshell.Io

import qs.services

Singleton {
    id: root

    property string devicePath: ""
    property int current: 0
    property int maximum: 0

    readonly property bool available: devicePath !== "" && maximum > 0
    readonly property int percent: available ? Math.round(current * 100 / maximum) : 0

    readonly property string script: Quickshell.env("HOME") + "/.scripts/brightness/changeBrightness.sh"

    function increase(): void {
        Commands.run(`. "${script}" increase`);
        refreshSoon.restart();
    }

    function decrease(): void {
        Commands.run(`. "${script}" decrease`);
        refreshSoon.restart();
    }

    Process {
        command: ["sh", "-c", "command -v brightnessctl > /dev/null && ls -d /sys/class/backlight/* 2>/dev/null | head -n 1"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.devicePath = text.trim()
        }
    }

    FileView {
        id: maximumFile

        path: root.devicePath ? root.devicePath + "/max_brightness" : ""
        printErrors: false
        onLoaded: root.maximum = parseInt(text()) || 0
    }

    FileView {
        id: currentFile

        path: root.devicePath ? root.devicePath + "/brightness" : ""
        printErrors: false
        onLoaded: root.current = parseInt(text()) || 0
    }

    Timer {
        interval: 250
        running: root.devicePath !== ""
        repeat: true
        onTriggered: currentFile.reload()
    }

    Timer {
        id: refreshSoon

        interval: 50
        onTriggered: currentFile.reload()
    }
}
