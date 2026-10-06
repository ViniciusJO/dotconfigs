//
// Caps Lock and Num Lock indicators (polybar caps / num modules): gray while
// off, psec while on, each followed by a space.
//
import QtQuick

import qs.components
import qs.config
import qs.services

Row {
    id: root

    property real fontSize: 13

    height: parent.height

    BarText {
        fontSize: root.fontSize
        text: "\u{f030e} "
        color: Locks.capsLock ? Theme.psec : Theme.gray
    }

    BarText {
        fontSize: root.fontSize
        text: " "
        color: Locks.numLock ? Theme.psec : Theme.gray
    }
}
