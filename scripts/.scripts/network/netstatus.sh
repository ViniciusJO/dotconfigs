#!/bin/bash
# netinfo-extended - Detailed summary of network interfaces and addresses

set -e

# Ensure `ip` command is available
command -v ip >/dev/null 2>&1 || { echo "Error: 'ip' command not found."; exit 1; }

# --- Helpers ---------------------------------------------------------------

green="\033[1;32m"
red="\033[1;31m"
yellow="\033[1;33m"
blue="\033[1;34m"
reset="\033[0m"

indent() { sed 's/^/  /'; }

# Get default gateways
default4=$(ip route show default 2>/dev/null | awk '/default/ {print $3}' | tr '\n' ' ')
default6=$(ip -6 route show default 2>/dev/null | awk '/default/ {print $3}' | tr '\n' ' ')

# Header
echo -e "\n${blue}=== Network Interfaces Overview ===${reset}\n"

# Loop over interfaces
while IFS= read -r line; do
    # Example: "2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 ..."
    iface=$(awk -F: '{print $2}' <<< "$line" | xargs)
    [[ -z "$iface" ]] && continue

    # Get interface details
    details=$(ip -o link show "$iface")
    state=$(awk '{for(i=1;i<=NF;i++) if($i ~ /state/) print $(i+1)}' <<< "$details")
    mac=$(awk '/link\/ether/ {print $2}' <<< "$details")
    mtu=$(awk '{for(i=1;i<=NF;i++) if($i=="mtu") print $(i+1)}' <<< "$details")
    type=$(awk '{print $3}' <<< "$details")

    # Color for state
    if [[ "$state" == "UP" ]]; then color=$green; else color=$red; fi

    echo -e "${color}${iface}${reset} - ${state} (${type})"
    echo "  MAC: ${mac:-N/A}"
    echo "  MTU: ${mtu:-N/A}"

    # Show default gateway if associated
    [[ $default4 =~ $iface ]] && echo "  Default IPv4 Gateway: $(ip route show default | awk -v i=$iface '$0 ~ i {print $3}')"
    [[ $default6 =~ $iface ]] && echo "  Default IPv6 Gateway: $(ip -6 route show default | awk -v i=$iface '$0 ~ i {print $3}')"

    # --- Addresses ---
    ip -br -4 a show "$iface" | while read -r _ _ addrs; do
        [[ -z "$addrs" ]] && continue
        echo "  IPv4 Addresses:"
        for addr in $addrs; do
            echo "    - $addr"
            full=$(ip -4 -o addr show dev "$iface" | grep "$addr")
            scope=$(awk '{for(i=1;i<=NF;i++) if($i=="scope") print $(i+1)}' <<< "$full")
            valid=$(awk '{for(i=1;i<=NF;i++) if($i=="valid_lft") print $(i+1)}' <<< "$full")
            pref=$(awk '{for(i=1;i<=NF;i++) if($i=="preferred_lft") print $(i+1)}' <<< "$full')
            label=$(awk '{for(i=1;i<=NF;i++) if($i=="label") print $(i+1)}' <<< "$full")
            flags=$(awk '{for(i=1;i<=NF;i++) if($i=="dynamic"||$i=="secondary"||$i=="primary"||$i=="temporary") printf "%s ",$i}' <<< "$full")
            echo "      scope: ${scope:-unknown}"
            echo "      label: ${label:-none}"
            echo "      flags: ${flags:-static}"
            echo "      valid_lft: ${valid:-forever}"
            echo "      preferred_lft: ${pref:-forever}"
        done
    done

    ip -br -6 a show "$iface" | while read -r _ _ addrs; do
        [[ -z "$addrs" ]] && continue
        echo "  IPv6 Addresses:"
        for addr in $addrs; do
            echo "    - $addr"
            full=$(ip -6 -o addr show dev "$iface" | grep "$addr")
            scope=$(awk '{for(i=1;i<=NF;i++) if($i=="scope") print $(i+1)}' <<< "$full")
            valid=$(awk '{for(i=1;i<=NF;i++) if($i=="valid_lft") print $(i+1)}' <<< "$full')
            pref=$(awk '{for(i=1;i<=NF;i++) if($i=="preferred_lft") print $(i+1)}' <<< "$full')
            flags=$(awk '{for(i=1;i<=NF;i++) if($i=="dynamic"||$i=="temporary"||$i=="mngtmpaddr") printf "%s ",$i}' <<< "$full")
            echo "      scope: ${scope:-unknown}"
            echo "      flags: ${flags:-static}"
            echo "      valid_lft: ${valid:-forever}"
            echo "      preferred_lft: ${pref:-forever}"
        done
    done

    echo
done < <(ip -o link show)


