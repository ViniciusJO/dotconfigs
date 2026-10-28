// 
// Now-playing media controls (MPRIS): previous, play/pause and next buttons,
// the track title and the output volume. Scroll or click the title to cycle
// through media sources. Hidden when no player is exposing a track.
//
import QtQuick
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire

import qs.components
import qs.config

Row {
    id: root

    property real fontSize: 13

    property int selectedIndex: -1

    readonly property var player: {
        const list = Mpris.players.values;
        if (list.length === 0)
            return null;
        if (root.selectedIndex >= 0 && root.selectedIndex < list.length)
            return list[root.selectedIndex];
        return list.find(p => p.playbackState === MprisPlaybackState.Playing)
            ?? list.find(p => p.playbackState === MprisPlaybackState.Paused)
            ?? list[0]
            ?? null;
    }
    readonly property bool playing: root.player?.playbackState === MprisPlaybackState.Playing

    readonly property int maxLength: 30
    property int scrollOffset: 0

    function ellipsize(value: string): string {
        return value.length > root.maxLength ? value.slice(0, root.maxLength - 3) + "..." : value;
    }

    readonly property string fullLabel: {
        const p = root.player;
        if (!p)
            return "";
        const title = p.trackTitle ?? "";
        if (title === "")
            return "";
        const artist = p.trackArtist ?? "";
        return artist !== "" ? `${artist} - ${title}` : title;
    }

    readonly property string label: root.ellipsize(root.fullLabel)

    function cyclePlayer(step: int): void {
        const list = Mpris.players.values;
        if (list.length === 0)
            return;
        let current = root.selectedIndex;
        if (current < 0 || current >= list.length) {
            current = list.indexOf(root.player);
            if (current < 0)
                current = 0;
        }
        root.selectedIndex = (current + step + list.length) % list.length;
    }

    function advanceLabel(): void {
        if (root.fullLabel.length > root.maxLength)
            root.scrollOffset = (root.scrollOffset + 1) % (root.fullLabel.length + 3);
    }

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink?.audio?.muted ?? false
    readonly property real volume: sink?.audio?.volume ?? 0
    readonly property real step: 0.05

    function setVolume(value: real): void {
        if (root.sink?.audio)
            root.sink.audio.volume = Math.max(0, Math.min(1, value));
    }

    function togglePlaying(): void {
        if (!root.player)
            return;
        if (root.playing) {
            if (root.player.canPause)
                root.player.pause();
        } else if (root.player.canPlay) {
            root.player.play();
        }
    }

    visible: root.player !== null && root.label !== ""
    height: parent.height

    BarText {
        fontSize: root.fontSize
        text: " "
    }

    TextMetrics {
        id: titleMetrics
        font: titleText.font
        text: "W".repeat(root.maxLength)
    }

    // Title: scroll or click to cycle through media sources.
    BarText {
        id: titleText
        width: titleMetrics.width
        fontSize: root.fontSize
        medium: true
        color: root.playing ? Theme.pprim : Theme.gray
        clip: true
        text: root.fullLabel.length > root.maxLength
              ? (root.fullLabel + "   " + root.fullLabel).slice(root.scrollOffset, root.scrollOffset + root.maxLength)
              : root.label + " "

        Timer {
            interval: 250
            repeat: true
            running: root.visible && root.fullLabel.length > root.maxLength
            onTriggered: root.advanceLabel()
        }

        ClickArea {
            width: titleText.width
            height: titleText.height
            leftAction: () => root.cyclePlayer(1)
            rightAction: () => root.cyclePlayer(-1)
            scrollUpAction: () => root.cyclePlayer(1)
            scrollDownAction: () => root.cyclePlayer(-1)
        }
    }

    BarText {
        fontSize: root.fontSize
        color: root.player?.canGoPrevious ? Theme.psec : Theme.darkGray
        text: " \u{f04ae} "

        ClickArea {
            leftAction: () => {
                if (root.player?.canGoPrevious)
                    root.player.previous();
            }
        }
    }

    BarText {
        fontSize: root.fontSize
        color: Theme.pprim
        text: root.playing ? " \u{f03e4} " : " \u{f040a} "

        ClickArea {
            leftAction: () => root.togglePlaying()
        }
    }

    BarText {
        id: next_btn
        fontSize: root.fontSize
        color: root.player?.canGoNext ? Theme.psec : Theme.darkGray
        text: " \u{f04ad} "

        ClickArea {
            leftAction: () => {
                if (root.player?.canGoNext)
                    root.player.next();
            }
        }
    }

    // Cava supplies 15 live FFT bands from the PipeWire output monitor.
    Item {
        id: visualizer
        property var spectrum: null
        width: 44
        height: parent.height
        visible: root.playing

        Component.onCompleted: {
            const source = `import QtQuick
import Quickshell.Io
Item {
    id: reader
    property var levels: Array(15).fill(0)
    Component.onCompleted: visualizer.spectrum = reader
    Process {
        command: ["sh", "-c", "printf '%s\\n' '[general]' 'bars = 15' 'framerate = 30' '[input]' 'method = pipewire' 'source = auto' '[output]' 'method = raw' 'channels = mono' 'raw_target = /dev/stdout' 'data_format = ascii' 'ascii_max_range = 100' 'bar_delimiter = 59' 'frame_delimiter = 10' | cava -p /dev/stdin"]
        running: visualizer.visible
        stdout: SplitParser {
            splitMarker: "\\n"
            onRead: data => {
                const values = data.trim().split(";").map(value => Number(value) / 100);
                if (values.length >= 15)
                    reader.levels = values.slice(0, 15);
            }
        }
    }
}`;
            Qt.createQmlObject(source, visualizer, "CavaSpectrumReader");
        }

        Row {
            anchors.verticalCenter: parent.verticalCenter
            // anchors.left: next_btn.right
            spacing: 3

            Repeater {
                model: 15

                Rectangle {
                    required property int index
                    width: 5
                    height: Math.max(2, Math.min(1, visualizer.spectrum?.levels[index] ?? 0) * 24)
                    radius: 1
                    color: Theme.psec
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }


    BarText {
        fontSize: root.fontSize
        text: " "
    }

    PwObjectTracker {
        objects: [root.sink]
    }
}
