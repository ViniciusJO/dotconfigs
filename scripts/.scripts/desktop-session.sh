#!/bin/sh
exec xinit /usr/bin/i3-with-shmlog -- /usr/bin/Xorg \
    -keeptty \
    vt"$XDG_VTNR" \
    # -nolisten tcp \
