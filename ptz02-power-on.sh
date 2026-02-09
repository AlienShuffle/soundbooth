#!/usr/bin/env bash
camera=$(basename $0 | cut -d- -f1)
cmd=$(basename $0 | cut -d- -f2- | cut -d. -f1)

case "$cmd" in
"power-on")
    cmdString="81 01 04 00 02 FF"
    ;;
"power-standby")
    cmdString="81 01 04 00 03 FF"
    ;;
*)
    echo "$0: error: unknown command '$cmd'" >&2
    exit 1
    ;;
esac
resp=$(./send-visca.sh "$camera.cbclocal" $cmdString)

# need to figure out how to parse to verify success. the 2s maybe variable.
if [ "$resp" = "9042ff9052ff" ]; then
    echo "$0: succesful" >&2
    exit 0
else
    echo "$0: error: $resp" >&2
    exit 1
fi
