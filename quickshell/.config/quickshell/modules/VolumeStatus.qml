//
// Default sink volume (polybar pulseaudio module, use-ui-max = false).
// Left click toggles mute, scroll changes volume by 5%, right click opens
// wiremix.
//
import QtQuick
import Quickshell.Services.Pipewire

import qs.components
import qs.config
import qs.services

BarText {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink?.audio?.muted ?? false
    readonly property real volume: sink?.audio?.volume ?? 0
    readonly property real step: 0.05

    function setVolume(value: real): void {
        if (sink?.audio)
            sink.audio.volume = Math.max(0, Math.min(1, value));
    }

    visible: sink !== null
    text: muted ? " \u{f075f} --- " : ` \u{f057e} ${Math.round(volume * 100)}% `
    color: muted ? Theme.gray : Theme.pprim

    PwObjectTracker {
        objects: [root.sink]
    }

    ClickArea {
        leftAction: () => {
            if (root.sink?.audio)
                root.sink.audio.muted = !root.muted;
        }
        rightAction: () => Commands.popupRun("wiremix")
        scrollUpAction: () => {
            if (root.volume < 1)
                root.setVolume(root.volume + root.step);
        }
        scrollDownAction: () => root.setVolume(root.volume - root.step)
    }
}
