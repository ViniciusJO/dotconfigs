//
// Focused window title (polybar title module: 4 spaces of padding, Medium
// font, at most 65 characters, "Arch i3" when no window is focused).
//
import QtQuick

import qs.components
import qs.config
import qs.services

BarText {
    readonly property int maxLength: 65
    readonly property string padding: "    "
    readonly property bool empty: I3State.title === ""

    function ellipsize(title: string): string {
        return title.length > maxLength ? title.slice(0, maxLength - 3) + "..." : title;
    }

    medium: true
    color: empty ? Theme.psec : Theme.pprim
    text: padding + (empty ? "Arch i3" : ellipsize(I3State.title)) + padding
}
