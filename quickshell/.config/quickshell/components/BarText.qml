//
// Text styled like a polybar label: font-0 (Regular) by default, font-1
// (Medium) when `medium` is set, vertically centered on the bar.
//
// Ligatures are disabled since polybar (Xft) never shapes them, so "---"
// stays three dashes.
//
import QtQuick
import QtQuick.Window
import qs.config

Text {
    /// Font size in (fractional) pixels.
    property real fontSize: 13
    property bool medium: false

    anchors.verticalCenter: parent?.verticalCenter
    // polybar renders the baseline one pixel lower than a centered Qt text.
    anchors.verticalCenterOffset: 1
    color: Theme.fg
    font.family: Theme.fontFamily
    font.pointSize: fontSize * 72 / (Screen.logicalPixelDensity * 25.4)
    font.features: ({
            "liga": 0,
            "calt": 0
        })
    font.weight: medium ? Font.Medium : Font.Normal
    // Full hinting rounds advances to whole pixels, matching Xft (8px cells at 10pt).
    font.hintingPreference: Font.PreferFullHinting
    textFormat: Text.PlainText
    renderType: Text.NativeRendering
}
