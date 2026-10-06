//
// StatusNotifierItem tray (polybar tray module: 8pt margin, 16pt spacing,
// icons at 66% of the bar height).
//
// Left click activates, middle click secondary-activates, right click shows
// the item menu and scrolling is forwarded to the item.
//
import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

Item {
    id: root

    required property var parentWindow
    property real dpi: 96

    readonly property int margin: Math.round(8 * dpi / 72)
    readonly property int iconSize: Math.round(height * 0.66)

    visible: SystemTray.items.values.length > 0
    height: parent.height
    implicitWidth: visible ? icons.implicitWidth + margin * 2 : 0

    Row {
        id: icons

        x: root.margin
        height: parent.height
        spacing: Math.round(16 * root.dpi / 72)

        Repeater {
            model: SystemTray.items

            delegate: Item {
                id: trayItem

                required property SystemTrayItem modelData

                width: root.iconSize
                height: icons.height

                IconImage {
                    anchors.centerIn: parent
                    implicitSize: root.iconSize
                    source: trayItem.modelData.icon
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                    onClicked: mouse => {
                        const item = trayItem.modelData;
                        if (mouse.button === Qt.MiddleButton) {
                            item.secondaryActivate();
                        } else if (mouse.button === Qt.RightButton || item.onlyMenu) {
                            if (item.hasMenu) {
                                const position = trayItem.mapToItem(null, 0, 0);
                                item.display(root.parentWindow, position.x, position.y);
                            }
                        } else {
                            item.activate();
                        }
                    }

                    onWheel: wheel => trayItem.modelData.scroll(wheel.angleDelta.y, false)
                }
            }
        }
    }
}
