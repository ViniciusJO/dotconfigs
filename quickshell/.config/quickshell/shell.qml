//@ pragma UseQApplication
//
// Quickshell port of the polybar configuration in ../polybar.
//
// Run with: qs -p /path/to/this/directory
//
import Quickshell

import qs.modules

ShellRoot {
    Variants {
        model: Quickshell.screens

        Bar {}
    }
}
