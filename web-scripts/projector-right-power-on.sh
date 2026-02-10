#!/usr/bin/env bash
# assume command format is projector-position-scrdevicet-name.sh
device="$(basename $0 | cut -d- -f1-2).cbclocal"
port=1024
cmd=$(basename $0 | cut -d- -f3- | cut -d. -f1)
script=$(basename $0)

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
echo "$script: Sending command to projector $device ($cmd)" >&2

respTwo=$(
    echo "$script: Connecting to projector at $device:$port" >&2
    {
        # Read the projector banner
        read BANNER
        echo "$script: Projector said: $BANNER" >&2

        if [[ "$BANNER" =~ "NTCONTROL 1" ]]; then
            RAND=$(echo "$BANNER" | awk '{print $3}')
            HASH=$(echo -n "CBCADMIN:CALVARY:$RAND" | md5sum | awk '{print $1}')
            CMD="00${HASH}${cmdString}\r"
        else
            CMD="00${cmdString}\r"
        fi

        echo "$script: Sending command '$CMD' to projector" >&2

        # Send command
        echo -en "$CMD"

        # Keep reading until projector closes connection or timeout
    } | nc -N $device $port
)

echo "$script: Projector said: '$respTwo'" >&2

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