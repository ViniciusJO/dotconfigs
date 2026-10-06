pragma Singleton

//
// Bar palette and fonts.
//
// `base` mirrors polybar/colors.ini (static). The `p*` colors mirror the
// [dyn_colors] section of ~/.cache/dyn_colors.ini, which is rewritten by an
// external tool: the file is watched and every binding using these colors is
// re-evaluated as soon as it changes.
//
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    // --- Static colors (polybar/colors.ini) ---------------------------------
    readonly property color bg: "#000000"
    readonly property color fg: "#bfbab0"
    readonly property color gray: "#555555"
    readonly property color darkGray: "#444444"
    readonly property color black: "#000000"
    readonly property color blueDarker: "#0771ed"

    // --- Dynamic colors (~/.cache/dyn_colors.ini) ----------------------------
    // Only the keys the bar uses are read. Defaults apply until the file is
    // read, or for keys that are missing / hold an invalid color.
    readonly property var defaults: ({
            pprim: "#cae690",
            psec: "#7db384",
            pterc: "#56996e",
            pcont: "#8c3c3a"
        })

    property var dynColors: defaults

    readonly property color pprim: dynColors.pprim
    readonly property color psec: dynColors.psec
    readonly property color pterc: dynColors.pterc
    readonly property color pcont: dynColors.pcont

    readonly property string dynColorsPath: Quickshell.env("HOME") + "/.cache/dyn_colors.ini"

    // --- Fonts (polybar/fonts.ini) -------------------------------------------
    readonly property string fontFamily: "JetBrainsMono Nerd Font"

    /// Converts a polybar point size into pixels for the given bar dpi.
    function pixelSize(points: real, dpi: real): real {
        return points * dpi / 72;
    }

    /// Parses the [dyn_colors] section of an ini file into a {key: color} map.
    function parseDynColors(text: string): var {
        const colors = Object.assign({}, defaults);
        const validColor = /^#([0-9a-f]{3}|[0-9a-f]{4}|[0-9a-f]{6}|[0-9a-f]{8})$/i;
        let inSection = false;

        for (const rawLine of text.split("\n")) {
            const line = rawLine.trim();
            if (!line || line.startsWith(";"))
                continue;

            const section = line.match(/^\[(.+)\]$/);
            if (section) {
                inSection = section[1].trim() === "dyn_colors";
                continue;
            }

            const separator = line.indexOf("=");
            if (!inSection || separator < 0)
                continue;

            const key = line.slice(0, separator).trim();
            if (!(key in defaults))
                continue;

            const value = line.slice(separator + 1).trim().replace(/^"(.*)"$/, "$1");
            if (validColor.test(value))
                colors[key] = value;
            else
                console.warn(`Theme: ignoring invalid color ${key} = ${value}`);
        }

        return colors;
    }

    FileView {
        id: dynColorsFile

        path: root.dynColorsPath
        watchChanges: true
        printErrors: false

        onLoaded: root.dynColors = root.parseDynColors(text())
        onLoadFailed: error => console.warn(`Theme: could not read ${root.dynColorsPath}, keeping current colors`)
        onFileChanged: reload()
    }
}
