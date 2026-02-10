#!/usr/bin/env bash
# PJLink control script for Panasonic VMZ71/VMZ51 series

device="$(basename $0 | cut -d- -f1-2).cbclocal"
cmd=$(basename $0 | cut -d- -f3- | cut -d. -f1)
script=$(basename "$0")
port=4352

case "$cmd" in
    power-on)
        pjcmd="%1POWR 1\r"
        ;;
    power-standby)
        pjcmd="%1POWR 0\r"
        ;;
    power-query)
        pjcmd="%1POWR ?\r"
        ;;
    *)
        echo "$script: error: unknown command '$cmd'" >&2
        exit 1
        ;;
esac

echo "$script: sending PJLINK command to $device ($cmd)" >&2

# Send the PJLink command over TCP and capture the response
resp=$(echo -ne "$pjcmd" | nc -w2 "$device" "$port" | tr -d '\r')

#echo "$script: response: '$resp'" >&2

# Interpret PJLink power responses
case "$resp" in
    *"POWR=0"*)
        echo "$script: projector is OFF (standby)" >&2
        ;;
    *"POWR=1"*)
        echo "$script: projector is ON" >&2
        ;;
    *"POWR=2"*)
        echo "$script: projector is COOLING" >&2
        ;;
    *"POWR=3"*)
        echo "$script: projector is WARMING UP" >&2
        ;;
    *"POWR=OK"*)
        echo "$script: PJLINK command was successful" >&2
        ;;
     *"POWR=ERR"*)
        echo "$script: PJLINK error (ERR)" >&2
        ;;
    *)
        echo "$script: unknown response '$resp'" >&2
        ;;
esac