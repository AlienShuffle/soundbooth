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
        echo "File $dst already exists. deleting link." >&2
    fi
    ln "$src" "$dst"
    chmod +x "$dst"
    echo "Linked $src to $dst and made it executable." >&2
}

(
    cd ./web-scripts
    basefile=./ptz01-power-on.sh
    if [ -f "$basefile" ]; then
        link_file "$basefile" ./ptz01-power-standby.sh
        link_file "$basefile" ./ptz02-power-on.sh
        link_file "$basefile" ./ptz02-power-standby.sh
    else
        echo "Error: $basefile file not found, needed to setup environment." >&2
        exit 1
    fi
    basefile=./projector-right-power-on.sh
    if [ -f "$basefile" ]; then
        link_file "$basefile" ./projector-right-power-standby.sh
        link_file "$basefile" ./projector-rear-power-on.sh
        link_file "$basefile" ./projector-rear-power-standby.sh
        link_file "$basefile" ./projector-left-power-on.sh
        link_file "$basefile" ./projector-left-power-standby.sh
    else
        echo "Error: $basefile file not found, needed to setup environment." >&2
        exit 1
    fi
)
sudo cp ./web-scripts/*.sh /opt/web-scripts/
sudo chown -R root:www-data /opt/web-scripts
sudo chmod -R 750 /opt/web-scripts

# copy in the cgi script for the web interface
sudo cp ./cgi-bin/* /usr/lib/cgi-bin/
sudo chown -R root:www-data /usr/lib/cgi-bin
sudo chmod -R 750 /usr/lib/cgi-bin
