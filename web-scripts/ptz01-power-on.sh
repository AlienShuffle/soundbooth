#!/usr/bin/env bash
# assume command format is camera-script-name.sh
camera="$(basename $0 | cut -d- -f1).cbclocal"
viscaPort=5678
cmd=$(basename $0 | cut -d- -f2- | cut -d. -f1)
script=$(basename $0)

case "$cmd" in
"power-on")
    cmdString="81 01 04 00 02 FF"
    ;;
"power-standby")
    cmdString="81 01 04 00 03 FF"
    ;;
*)
    echo "$script: error: unknown command '$cmd'" >&2
    exit 1
    ;;
esac

# Build binary command
TMP=$(mktemp)
echo -n "$cmdString" | xxd -r -p >"$TMP"
echo "Sending VISCA command to $camera:$viscaPort $cmdString ($cmd)" >&2
# Send + receive over the same TCP connection
# -w2 = 2-second timeout waiting for response
resp=$(nc -w2 "$camera" "$viscaPort" <"$TMP" | xxd -p)
# xxd -p converts binary response to hex string for display on stdout.
rm -f "$TMP"

case "$resp" in
"9041ff9051ff" | "9042ff9052ff")
    echo "$script: succesful" >&2
    exit 0
    ;;
*)
    echo -e "$script: error: $resp\n\tlikely already in $cmd state" >&2
    exit 1
    ;;
esac
