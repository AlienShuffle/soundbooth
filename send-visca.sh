#!/usr/bin/env bash
# send-visca.sh - Send Sony VISCA command over IP (TCP) from Bash
# Usage: ./send-visca.sh <camera_ip> <hex_bytes...>
# Example: ./send-visca.sh 192.168.1.100 81 01 06 01 FF

set -e
VISCA_PORT=5678

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <camera_ip> <hex_bytes...>" >&2
    echo "Example: $0 192.168.1.100 81 01 06 01 FF" >&2
    exit 1
fi
CAMERA_IP="$1"
shift

# Validate hex bytes
for byte in "$@"; do
    if ! [[ "$byte" =~ ^[0-9A-Fa-f]{2}$ ]]; then
        echo "Error: '$byte' is not a 2-digit hex byte." >&2
        exit 1
    fi
done

TMP=$(mktemp)

# Build binary command
echo -n "$@" | xxd -r -p >"$TMP"

echo "Sending VISCA command to $CAMERA_IP:$VISCA_PORT $@" >&2

# Send + receive over the same TCP connection
# -w2 = 2-second timeout waiting for response
nc -w2 "$CAMERA_IP" "$VISCA_PORT" <"$TMP" | xxd -p
# xxd -p converts binary response to hex string for display on stdout.
rm -f "$TMP"