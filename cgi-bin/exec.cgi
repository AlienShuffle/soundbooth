#!/bin/bash

# Get script name from query
SCRIPT=$(echo "$QUERY_STRING" | sed 's/^run=//')

# SSE headers
echo "Content-Type: text/event-stream"
echo "Cache-Control: no-cache"
echo ""

# Announce start
echo "data: Starting $SCRIPT.sh..."
echo

# Run the script and stream output as SSE
stdbuf -o0 -e0 /opt/web-scripts/"$SCRIPT".sh 2>&1 | while IFS= read -r line; do
    echo "data: $line"
    echo
    sleep 0.05 # helps smoothness and browser responsiveness
done

# End event
echo "data: [DONE]"
echo
