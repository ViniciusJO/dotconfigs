//
// i3 workspaces of this bar's monitor plus the binding mode (polybar i3
// module: pin-workspaces, index-sort, enable-click, no scroll).
//
import QtQuick
import Quickshell
import Quickshell.I3

import qs.components
import qs.config
import qs.services

Row {
    id: root

    required property ShellScreen screen
    property real fontSize: 13

    readonly property var workspaces: I3.workspaces.values
        .filter(workspace => workspace.monitor?.name === root.screen?.name)
        .sort((a, b) => a.number - b.number)

    height: parent.height

    Repeater {
        model: root.workspaces

        delegate: Rectangle {
            id: workspaceItem

            required property I3Workspace modelData

            // Same precedence as polybar: focused > urgent > visible > unfocused.
            readonly property string status: {
                if (modelData.focused)
                    return "focused";
                if (modelData.urgent)
                    return "urgent";
                if (modelData.active)
                    return "visible";
                return "unfocused";
            }

            width: label.implicitWidth
            height: root.height
            color: {
                if (status === "focused")
                    return Theme.pprim;
                if (status === "urgent")
                    return Theme.psec;
                return "transparent";
            }

            BarText {
                id: label

                fontSize: root.fontSize
                text: ` ${workspaceItem.modelData.number >= 0 ? workspaceItem.modelData.number : workspaceItem.modelData.name} `
                color: {
                    if (workspaceItem.status === "focused" || workspaceItem.status === "urgent")
                        return Theme.black;
                    if (workspaceItem.status === "unfocused")
                        return Theme.pprim;
                    return Theme.fg;
                }
            }

            ClickArea {
                leftAction: () => workspaceItem.modelData.activate()
            }
        }
    }

    // Literal space between <label-state> and <label-mode>.
    BarText {
        fontSize: root.fontSize
        text: " "
    }

    Rectangle {
        visible: I3State.mode !== "default"
        width: modeLabel.implicitWidth
        height: root.height
        color: Theme.psec

        BarText {
            id: modeLabel

            fontSize: root.fontSize
            text: ` ${I3State.mode} `
            color: Theme.bg
        }
    }
}
