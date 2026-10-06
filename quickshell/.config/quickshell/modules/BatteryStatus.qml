//
// Battery level (polybar battery_custom module, scripts/battery.sh).
//
import QtQuick

import qs.components
import qs.config
import qs.services

BarText {
    readonly property string icon: {
        if (Battery.charging)
            return "";
        if (Battery.capacity >= 90)
            return " ";
        if (Battery.capacity >= 70)
            return " ";
        if (Battery.capacity >= 50)
            return " ";
        if (Battery.capacity >= 30)
            return " ";
        return " ";
    }

    visible: Battery.available
    text: Battery.full ? "    Full " : `  ${icon} ${Battery.capacity}% `
    color: {
        if (Battery.full)
            return Theme.pterc;
        return Battery.charging ? Theme.pprim : Theme.psec;
    }
}
