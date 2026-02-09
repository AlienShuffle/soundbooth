#!/usr/bin/env bash
# assume command format is projector-script-name.sh
IP="$(basename $0 | cut -d- -f1-2).cbclocal"
PORT=1024
cmd=$(basename $0 | cut -d- -f3- | cut -d. -f1)

echo "Sending command '$cmd' to projector at $IP:$PORT"

case "$cmd" in
"power-on")
    cmdString="PON"
    ;;
"power-standby")
    cmdString="POF"
    ;;
*)
    echo "$0: error: unknown command '$cmd'" >&2
    exit 1
    ;;
esac

# Open TCP session and capture the initial response
RESP=$(echo | nc $IP $PORT | head -n1)

echo "Projector said: $RESP"

if [[ "$RESP" =~ "NTCONTROL 1" ]]; then
    RAND=$(echo "$RESP" | awk '{print $3}')
    HASH=$(echo -n "CBCADMIN:CALVARY:$RAND" | md5sum | awk '{print $1}')
    CMD="00${HASH}${cmdString}\r"
else
    CMD="00${cmdString}\r"
fi

respTwo=$(echo -e "$CMD" | nc $IP $PORT)

case "$respTwo" in
"9041ff9051ff" | "9042ff9052ff")
    echo "$0: succesful" >&2
    exit 0
    ;;

*)
    echo "$0: error: $resp" >&2
    exit 1
    ;;
esac
