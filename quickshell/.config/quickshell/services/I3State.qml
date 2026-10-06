pragma Singleton

//
// i3 state not covered by Quickshell's I3 singleton: the focused window
// title (polybar internal/xwindow) and the current binding mode.
//
// Focus and title events carry the focused container, so they update the
// title directly. Anything else that may change which window is focused
// (close, move, workspace switch) triggers a re-read of the i3 tree.
//
import QtQuick
import Quickshell
import Quickshell.I3
import Quickshell.Io

Singleton {
    id: root

    /// Focused window title, empty when the focused workspace has no window.
    property string title: ""

    /// Current binding mode ("default" when no mode is active).
    property string mode: "default"

    // Set when a refresh is requested while a tree read is still running.
    property bool refreshPending: false

    /// Returns the focused leaf container of an i3 tree, or null.
    function findFocused(node: var): var {
        if (node.focused)
            return node;

        for (const child of (node.nodes ?? []).concat(node.floating_nodes ?? [])) {
            const found = findFocused(child);
            if (found)
                return found;
        }
        return null;
    }

    function applyTree(json: string): void {
        try {
            const focused = findFocused(JSON.parse(json));
            const hasWindow = focused && focused.window !== null && focused.window !== undefined;
            title = hasWindow ? (focused.name ?? "") : "";
        } catch (error) {
            console.warn(`I3State: could not parse i3 tree: ${error}`);
        }
    }

    function refresh(): void {
        if (treeReader.running)
            refreshPending = true;
        else
            treeReader.running = true;
    }

    function handleEvent(type: string, data: var): void {
        if (type.endsWith("mode")) {
            mode = data.change ?? "default";
            return;
        }

        const container = data.container;
        if (type.endsWith("window") && container?.focused && (data.change === "focus" || data.change === "title")) {
            title = container.name ?? "";
            return;
        }

        refresh();
    }

    Process {
        id: treeReader

        command: ["i3-msg", "-t", "get_tree"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.applyTree(text)
        }

        onExited: {
            if (root.refreshPending) {
                root.refreshPending = false;
                running = true;
            }
        }
    }

    I3IpcListener {
        subscriptions: ["window", "workspace", "mode"]

        onIpcEvent: event => {
            try {
                root.handleEvent(event.type, JSON.parse(event.data));
            } catch (error) {
                console.warn(`I3State: bad ipc event ${event.type}: ${error}`);
            }
        }
    }
}
