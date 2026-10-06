//
// Keybindings hint button (polybar keyhint module, secondary bar only).
//
import QtQuick
import Quickshell

import qs.components
import qs.config
import qs.services

BarText {
    text: "  "
    color: Theme.blueDarker

    ClickArea {
        leftAction: () => Commands.run(`xfce4-terminal -e "less ${Quickshell.env("HOME")}/.config/bspwm/keybindings"`)
    }
}
