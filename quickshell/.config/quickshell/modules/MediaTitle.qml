import QtQuick
import Quickshell.Services.Mpris

import qs.components
import qs.config

Row {
    id: root

    signal clicked()

    required property var players
    property real fontSize: 13
    property string selectedPlayerDbusName: ""
    property int scrollOffset: 0

    readonly property var player: {
        const list = root.players ?? [];
        if (list.length === 0)
            return null;

        if (root.selectedPlayerDbusName !== "") {
            const selected = list.find(p => p.dbusName === root.selectedPlayerDbusName);
            if (selected)
                return selected;
        }

        return list.find(p => p.playbackState === MprisPlaybackState.Playing)
            ?? list.find(p => p.playbackState === MprisPlaybackState.Paused)
            ?? list[0]
            ?? null;
    }
    readonly property bool playing: root.player?.playbackState === MprisPlaybackState.Playing
    readonly property int maxLength: 30
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
    readonly property string label: root.fullLabel.length > root.maxLength
        ? root.fullLabel.slice(0, root.maxLength - 3) + "..."
        : root.fullLabel

    function cyclePlayer(step: int): void {
        const list = root.players ?? [];
        if (list.length === 0)
            return;

        const current = list.indexOf(root.player);
        const index = ((current < 0 ? 0 : current) + step + list.length) % list.length;
        const nextPlayer = list[index];
        root.selectedPlayerDbusName = nextPlayer.dbusName ?? "";
        root.scrollOffset = 0;
    }

    function advanceLabel(): void {
        if (root.fullLabel.length > root.maxLength)
            root.scrollOffset = (root.scrollOffset + 1) % (root.fullLabel.length + 3);
    }

    visible: root.player !== null && root.fullLabel !== ""

    TextMetrics {
        id: titleMetrics
        font: titleText.font
        text: "W".repeat(root.maxLength)
    }

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
            leftAction: () => root.clicked()
            rightAction: () => root.clicked()
            scrollUpAction: () => root.cyclePlayer(1)
            scrollDownAction: () => root.cyclePlayer(-1)
        }
    }
}
