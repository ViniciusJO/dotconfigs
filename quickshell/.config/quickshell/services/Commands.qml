pragma Singleton

//
// Shell command helpers shared by the bar modules (the polybar click actions).
//
import Quickshell

Singleton {
    /// Floating terminal popup, matched by the i3 `for_window [class="BarPopup"]` rule.
    readonly property string popup: 'wezterm --config window_background_opacity=1 start --class "BarPopup"'

    /// Runs a command through `sh -c`, detached from the shell.
    function run(command: string): void {
        Quickshell.execDetached(["sh", "-c", command]);
    }

    /// Opens `command` in the BarPopup terminal.
    function popupRun(command: string): void {
        run(`${popup} ${command}`);
    }
}
