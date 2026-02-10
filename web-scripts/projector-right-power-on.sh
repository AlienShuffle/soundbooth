#!/usr/bin/env bash
# assume command format is projector-position-scrdevicet-name.sh
device="$(basename $0 | cut -d- -f1-2).cbclocal"
port=1024
cmd=$(basename $0 | cut -d- -f3- | cut -d. -f1)
script=$(basename $0)

echo "Setting up command '$cmd' to projector at $device:$port" >&2

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
    echo "$script: error: unknown command '$cmd'" >&2
    exit 1
    ;;
esac

# Open TCP session and capture the initial response
echo "opening port $port to projector $device" >&2
respOne=$(echo | nc $device $port | head -n1)

echo "Projector said: $respOne" >&2

if [[ "$respOne" =~ "NTCONTROL 1" ]]; then
    RAND=$(echo "$respOne" | awk '{print $3}')
    HASH=$(echo -n "CBCADMIN:CALVARY:$RAND" | md5sum | awk '{print $1}')
    CMD="00${HASH}${cmdString}\r"
else
    CMD="00${cmdString}\r"
fi
echo "Sending command '$CMD' to projector" >&2
respTwo=$(echo -e "$CMD" | nc -w2 $device $port)

echo "Projector said: '$respTwo'" >&2

case "$respTwo" in
"001")
    echo "$script: power is on" >&2
    exit 0
    ;;
"000")
    echo "$script: power is off (standby)" >&2
    exit 0
    ;;
"")
    echo "$script: empty response" >&2
    exit 0
    ;;
*)
    echo "$script: error: unknown response '$respTwo'" >&2
    exit 1
    ;;
esac
