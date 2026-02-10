#!/usr/bin/env bash
# assume command format is projector-position-scrdevicet-name.sh
device="$(basename $0 | cut -d- -f1-2).cbclocal"
port=1024
cmd=$(basename $0 | cut -d- -f3- | cut -d. -f1)

echo "Sending command '$cmd' to projector at $device:$port"

case "$cmd" in
"power-on")
    cmdString="PON"
    ;;
"power-standby")
    cmdString="POF"
    ;;
"power-query")
    cmdString="QPW"
    ;;
*)
    echo "$0: error: unknown command '$cmd'" >&2
    exit 1
    ;;
esac

# Open TCP session and capture the initial response
RESP=$(echo | nc $device $port | head -n1)

echo "Projector said: $RESP"

if [[ "$RESP" =~ "NTCONTROL 1" ]]; then
    RAND=$(echo "$RESP" | awk '{print $3}')
    HASH=$(echo -n "CBCADMIN:CALVARY:$RAND" | md5sum | awk '{print $1}')
    CMD="00${HASH}${cmdString}\r"
else
    CMD="00${cmdString}\r"
fi

respTwo=$(echo -e "$CMD" | nc $device $port)

echo "Projector said: $respTwo"

case "$respTwo" in
"001")
    echo "$0: power is on" >&2
    exit 0
    ;;
"000")
    echo "$0: power is off (standby)" >&2
    exit 0
    ;;
*)
    echo "$0: error: $resp" >&2
    exit 1
    ;;
esac
