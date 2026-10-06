//
// Screen brightness (polybar backlight module). Scroll changes brightness
// through changeBrightness.sh.
//
import QtQuick

import qs.components
import qs.config
import qs.services

BarText {
    // changeBrightness.sh get_with_padding: one digit values get a leading space.
    readonly property string padded: Backlight.percent < 10 ? ` ${Backlight.percent}` : `${Backlight.percent}`

    visible: Backlight.available
    medium: true
    text: `  ${padded}%`
    color: Theme.pprim

    ClickArea {
        scrollUpAction: () => Backlight.increase()
        scrollDownAction: () => Backlight.decrease()
    }
}
