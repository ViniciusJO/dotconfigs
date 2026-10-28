import QtQuick
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire

import qs.components
import qs.config

Row {
    id: root

    required property var player
    required property int font_size
    readonly property bool playing: root.player?.playbackState === MprisPlaybackState.Playing

    function togglePlaying(): void {
        if (root.playing) {
            if (root.player?.canPause)
                root.player.pause();
        } else if (root.player?.canPlay) {
            root.player.play();
        }
    }

    BarText {
        fontSize: root.font_size
        color: root.player?.canGoPrevious ? Theme.pterc : Theme.darkGray
        text: " \u{f04ae} "

        ClickArea {
            leftAction: () => {
                if (root.player?.canGoPrevious)
                    root.player.previous();
            }
        }
    }

    BarText {
        fontSize: root.font_size
        color: Theme.psec
        text: root.playing ? " \u{f03e4} " : " \u{f040a} "

        ClickArea {
            leftAction: () => root.togglePlaying()
        }
    }

    BarText {
        fontSize: root.font_size
        color: root.player?.canGoNext ? Theme.pterc : Theme.darkGray
        text: " \u{f04ad} "

        ClickArea {
            leftAction: () => {
                if (root.player?.canGoNext)
                    root.player.next();
            }
        }
    }
}
