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

run_script mojo-jojo
run_script config-crestron.sh
run_script ptz01-power-on.sh
run_script ptz02-power-on.sh
run_script projector-right-power-on.sh
run_script projector-rear-power-on.sh
run_script projector-left-power-on.sh
