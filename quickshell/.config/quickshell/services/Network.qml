pragma Singleton

//
// Network status (polybar net_custom module), refreshed every 3 seconds by
// running scripts/network.sh.
//
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    /// One of "wifi", "eth", "down", "error" or "" (hidden).
    property string kind: ""
    property string iface: ""
    property string ssid: ""
    property string signal: ""

    function apply(output: string): void {
        const fields = output.trim().split("\t");
        kind = fields[0] ?? "";
        iface = fields[1] ?? "";
        ssid = fields[2] ?? "";
        signal = fields[3] ?? "";
    }

    Process {
        id: reader

        command: [Quickshell.shellDir + "/scripts/network.sh"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.apply(text)
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: reader.running = true
    }
}
