//
// Bottom bar for one screen.
//
// The primary screen gets polybar's `main` bar (96 dpi, 30px, full module
// set); every other screen gets `pc_sec` (133 dpi, 29px, workspaces, key hint,
// title and clock, modules separated by a space).
//
import QtQuick
import Quickshell
import Quickshell.Services.Mpris

import qs.components
import qs.config
import qs.modules

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
  implicitHeight: isMain ? 30 + (mediaProgress.visible ? mediaProgress.height : 0) : 29
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

      // MediaControl { }
    }


    // fixed-center: centered on the bar, pushed left by a large right
    // block, but never over the left block (polybar renderer::block_x).
    // WindowTitle {
    //     id: title
    //
    //     fontSize: bar.fontSize
    //     x: {
    //         const minX = left.width + bar.blockGap;
    //         const maxEnd = parent.width - right.width - bar.blockGap;
    //         const center = Math.min(parent.width / 2, maxEnd - width / 2);
    //         return Math.max(center - width / 2, minX);
    //     }
    // }
    Item {
      anchors.verticalCenter: parent.verticalCenter
      anchors.horizontalCenter: parent.horizontalCenter
      id: mediaSwitcher
      property bool mediaVisible: false
      // width: mediaVisible ? mediaRow.implicitWidth : windowTitle.width
      height: parent.height
      // x: {
      //     const minX = left.width + bar.blockGap;
      //     const maxEnd = parent.width - right.width - bar.blockGap;
      //     const center = Math.min(parent.width / 2, maxEnd - width / 2);
      //     return Math.max(center - width / 2, minX);
      // }

      Item {
        id: switcher
        anchors.horizontalCenter: parent.horizontalCenter
        property bool mediaVisible: false
        property int inner_margin: 45
        height: parent.height

        property bool mediaChoiceMade: false

        function chooseMediaView(showMedia: bool): void {
          mediaChoiceMade = true;
          mediaVisible = showMedia;
        }

        Binding {
          target: switcher
          property: "mediaVisible"
          value: Mpris.players.values.length > 0
          when: !switcher.mediaChoiceMade
        }

        WindowTitle {
          id: windowTitle
          anchors.horizontalCenter: parent.horizontalCenter
          visible: !switcher.mediaVisible
          fontSize: bar.fontSize
            ClickArea {
              leftAction: () => switcher.chooseMediaView(true)
              rightAction: () => switcher.chooseMediaView(true)
            }
        }
        Item {
            anchors.centerIn: parent
            visible: switcher.mediaVisible
            height: parent.height
          Row {
            id: mediaRow
            anchors.centerIn: parent
            // visible: switcher.mediaVisible
            height: parent.height
            Item {
              id: mediaControls
              width: Math.max(mediaVisu.width, mediaBtn.implicitWidth) * 1.5
              height: parent.height


              // Rectangle {
              //   id: mediaProgress
              //   property var player: mediaTitle.player
              //   readonly property real progress: player && player.positionSupported && player.lengthSupported && player.length > 0
              //   ? Math.max(0, Math.min(1, player.position / player.length))
              //   : 0
              //
              //   anchors.top: parent.top
              //   anchors.left: parent.left
              //   width: parent.width
              //   height: 1
              //   z: 1000
              //   visible: switcher.mediaVisible && player !== null && player.positionSupported && player.lengthSupported && player.length > 0
              //   color: "#000000"
              //
              //   Rectangle {
              //     width: mediaProgress.width * mediaProgress.progress
              //     height: parent.height
              //     color: Theme.pprim
              //   }
              //
              //   Timer {
              //     interval: 250
              //     repeat: true
              //     running: mediaProgress.player?.playbackState === MprisPlaybackState.Playing
              //     onTriggered: mediaProgress.player.positionChanged()
              //   }
              // }
   

              HoverHandler {
                id: controlsHover
              }

              MediaVisualizer {
                id: mediaVisu
                anchors.centerIn: parent
                // player: mediaTitle.player
                // playing: mediaTitle.playing
                height: parent.height
                visible: !controlsHover.hovered
                bars_width: 3
                bars_spacing: 1
                bars_radius: 0
              }

              MediaButtons {
                id: mediaBtn
                anchors.centerIn: parent
                visible: controlsHover.hovered
                player: mediaTitle.player
                font_size: 16
              }
            }

            MediaTitle {
              // anchors.right: mediaVisu.left
              // anchors.rightMargin: switcher.inner_margin
              anchors.verticalCenter: parent.verticalCenter
              id: mediaTitle
              players: Mpris.players.values
              fontSize: bar.fontSize
              onClicked: switcher.chooseMediaView(false)
            }
          }


          Rectangle {
            id: mediaProgress
            property var player: mediaTitle.player
            readonly property real progress: player && player.positionSupported && player.lengthSupported && player.length > 0
            ? Math.max(0, Math.min(1, player.position / player.length))
            : 0

            anchors.top: parent.top
            anchors.left: parent.left
            width: parent.width
            height: 1
            z: 1000
            visible: switcher.mediaVisible && player !== null && player.positionSupported && player.lengthSupported && player.length > 0
            color: "#000000"

            Rectangle {
              width: mediaProgress.width * mediaProgress.progress
              height: parent.height
              color: Theme.pprim
            }

            Timer {
              interval: 250
              repeat: true
              running: mediaProgress.player?.playbackState === MprisPlaybackState.Playing
              onTriggered: mediaProgress.player.positionChanged()
            }
          }
        }
      }

    }

    Row {
      id: right
      anchors.right: parent.right

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
