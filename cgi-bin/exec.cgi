#!/bin/bash
# this is the cgi-bin/exec.cgi script that runs the selected script and streams output as SSE

SCRIPT=$(echo "$QUERY_STRING" | sed 's/^run=//')

# SSE headers
echo "Content-Type: text/event-stream"
echo "Cache-Control: no-cache"
echo ""

# Announce start
echo "data: Starting $SCRIPT.sh..."
echo

# Execute script and stream its output
stdbuf -o0 -e0 /opt/web-scripts/"$SCRIPT".sh 2>&1 | while IFS= read -r line; do
    echo "data: $line"
    echo
done

# Send DONE message
echo "data: [DONE]"
echo