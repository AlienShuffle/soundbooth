#!/bin/bash

function run_script() {
    local script="$(basename $1)"
    local dst="/opt/web-scripts/$script"
    if [ -x "$dst" ]; then
        echo -e "---\n$script" >&2
        "$dst"
    else
        echo "Error: $dst is not executable or does not exist." >&2
    fi
}

run_script ptz01-power-standby.sh
run_script ptz02-power-standby.sh
run_script projector-right-power-standby.sh
run_script projector-rear-power-standby.sh
run_script projector-left-power-standby.sh