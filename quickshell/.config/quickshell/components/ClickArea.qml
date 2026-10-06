//
// Mouse handler mapping polybar's click-left / click-right / scroll-up /
// scroll-down actions to optional callbacks.
//
// Smooth scrolling devices (touchpads, high resolution wheels) deliver many
// small wheel events per gesture. Deltas are accumulated and one scroll
// action fires per full wheel notch, matching polybar's discrete steps.
//
import QtQuick

MouseArea {
    property var leftAction: null
    property var rightAction: null
    property var middleAction: null
    property var scrollUpAction: null
    property var scrollDownAction: null

    /// angleDelta of one standard mouse wheel notch.
    readonly property int notch: 120
    property int accumulated: 0

    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

    onClicked: mouse => {
        if (mouse.button === Qt.LeftButton && leftAction)
            leftAction();
        else if (mouse.button === Qt.RightButton && rightAction)
            rightAction();
        else if (mouse.button === Qt.MiddleButton && middleAction)
            middleAction();
    }

    onWheel: wheel => {
        const delta = wheel.angleDelta.y;
        if (delta === 0)
            return;

        // Restart the count when the scroll direction flips.
        if (Math.sign(delta) !== Math.sign(accumulated))
            accumulated = 0;
        accumulated += delta;

        while (accumulated >= notch) {
            accumulated -= notch;
            if (scrollUpAction)
                scrollUpAction();
        }
        while (accumulated <= -notch) {
            accumulated += notch;
            if (scrollDownAction)
                scrollDownAction();
        }
    }
}
