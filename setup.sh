#!/usr/bin/env bash
#
# create a set of links to the same file for each camera's power on/off scripts. This allows for a 
# single file to be edited for all cameras, while still having separate files
# for each camera's power on/off actions.
#
function link_file() {
    local src="$1"
    local dst="$2"
    if [ -f "$dst" ]; then
        echo "File $dst already exists. Skipping link." >&2
    else
        ln "$src" "$dst"
        chmod +x "$dst"
        echo "Linked $src to $dst and made it executable." >&2
    fi
}
basefile=./ptz01-power-on.sh
if [ -f "$basefile" ]; then
    link_file "$basefile" ./ptz01-power-on.sh
    link_file "$basefile" ./ptz01-power-standby.sh
    link_file "$basefile" ./ptz02-power-on.sh
    link_file "$basefile" ./ptz02-power-standby.sh
else
    echo "Error: $basefile file not found, needed to setup environment." >&2
    exit 1
fi
