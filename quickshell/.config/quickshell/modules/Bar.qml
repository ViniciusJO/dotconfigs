//
// Bottom bar for one screen.
//
// The primary screen gets polybar's `main` bar (96 dpi, 30px, full module
// set); every other screen gets `pc_sec` (133 dpi, 29px, workspaces, key hint,
// title and clock, modules separated by a space).
//
import QtQuick
import Quickshell

import qs.components
import qs.config

PanelWindow {
    id: bar

    required property ShellScreen modelData

    // Qt lists the X11 primary output first.
    readonly property bool isMain: modelData.name === Quickshell.screens[0]?.name
    readonly property real dpi: isMain ? 96 : 133
    readonly property real fontSize: Theme.pixelSize(10, dpi)

    // Minimum distance polybar keeps between the left, center and right blocks.
    readonly property int blockGap: 20

    screen: modelData
    anchors {
        bottom: true
        left: true
        right: true
    }
    implicitHeight: isMain ? 30 : 29
    color: Theme.bg

    Item {
        anchors.fill: parent

        Row {
            id: left

            anchors.left: parent.left
            height: parent.height

            BarText {
                fontSize: bar.fontSize
                text: " "
            }

            Workspaces {
                screen: bar.modelData
                fontSize: bar.fontSize
            }

            // separator + sps + separator
            BarText {
                visible: !bar.isMain
                fontSize: bar.fontSize
                text: "     "
            }

            KeyHint {
                visible: !bar.isMain
                fontSize: bar.fontSize
            }
        }

        // fixed-center: centered on the bar, pushed left by a large right
        // block, but never over the left block (polybar renderer::block_x).
        WindowTitle {
            id: title

            fontSize: bar.fontSize
            x: {
                const minX = left.width + bar.blockGap;
                const maxEnd = parent.width - right.width - bar.blockGap;
                const center = Math.min(parent.width / 2, maxEnd - width / 2);
                return Math.max(center - width / 2, minX);
            }
        }

        Row {
            id: right

            x: Math.max(parent.width - width, title.x + title.width + bar.blockGap)
            height: parent.height

            // caps num bluetooth pulseaudio backlight battery_custom net_custom hsps
            Row {
                visible: bar.isMain
                height: parent.height

                LockKeys {
                    fontSize: bar.fontSize
                }

                BluetoothStatus {
                    fontSize: bar.fontSize
                }

                VolumeStatus {
                    fontSize: bar.fontSize
                }

                BacklightStatus {
                    fontSize: bar.fontSize
                }

                BatteryStatus {
                    fontSize: bar.fontSize
                }

                NetworkStatus {
                    fontSize: bar.fontSize
                }

                BarText {
                    fontSize: bar.fontSize
                    text: " "
                }
            }

            Clock {
                fontSize: bar.fontSize
            }

            // hsps on the main bar, separator + sps on the secondary one.
            BarText {
                fontSize: bar.fontSize
                text: bar.isMain ? " " : "    "
            }

            // tray rotate
            Row {
                visible: bar.isMain
                height: parent.height

                SysTray {
                    parentWindow: bar
                    dpi: bar.dpi
                }

                RotateStatus {
                    fontSize: bar.fontSize
                }
            }

            BarText {
                fontSize: bar.fontSize
                text: " "
            }
        }
    }
}
