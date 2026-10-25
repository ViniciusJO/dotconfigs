#!/bin/bash
set -u

coproc MONITOR {
    /usr/bin/dbus-monitor --system \
        "type='signal',interface='org.freedesktop.login1.Manager',member='PrepareForShutdown'"
}

while IFS= read -r line <&"${MONITOR[0]}"; do
    case "$line" in
        *member=PrepareForShutdown*)
            if IFS= read -r argument <&"${MONITOR[0]}"; then
                case "$argument" in
                    *"boolean true"*)
                        $HOME/.scripts/shutdown_procedures.sh \
                            || :

                        # Stop the monitor so the inhibitor is released.
                        kill "$MONITOR_PID" 2>/dev/null || :
                        wait "$MONITOR_PID" 2>/dev/null || :
                        exit 0
                        ;;
                esac
            fi
            ;;
    esac
done


#
# #!/bin/sh
# set -eu
#
# /usr/bin/dbus-monitor --system \
#     "type='signal',interface='org.freedesktop.login1.Manager',member='PrepareForShutdown'" |
# while IFS= read -r line; do
#     case "$line" in
#         *member=PrepareForShutdown*)
#             if IFS= read -r argument; then
#                 case "$argument" in
#                     *"boolean true"*)
#                         $HOME/.scripts/shutdown_procedures.sh \
#                             || :
#                         exit 0
#                         ;;
#                 esac
#             fi
#             ;;
#     esac
# done


