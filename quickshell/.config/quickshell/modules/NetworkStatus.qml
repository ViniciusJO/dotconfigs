//
// Network status (polybar net_custom module). Left click shows `ip -c a`,
// right click opens nmtui, both in the BarPopup terminal.
//
import QtQuick

import qs.components
import qs.config
import qs.services

BarText {
    visible: Network.kind !== ""
    text: {
        switch (Network.kind) {
        case "wifi":
            return ` [${Network.iface}] ${Network.ssid} (${Network.signal}%) `;
        case "eth":
            return ` [${Network.iface}] `;
        case "error":
            return " [ net error ] ";
        default:
            return " [-] ";
        }
    }
    color: {
        switch (Network.kind) {
        case "wifi":
        case "eth":
            return Theme.pterc;
        case "error":
            return Theme.psec;
        default:
            return Theme.darkGray;
        }
    }

    ClickArea {
        leftAction: () => Commands.popupRun(`sh -c 'ip -c a && read -rsd q; exit'`)
        rightAction: () => Commands.popupRun(`sh -c 'sleep 0.2 && nmtui'`)
    }
}
