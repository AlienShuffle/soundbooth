#!/bin/bash

echo "Content-type: text/html"
echo ""

# If a script name was submitted, run it
if [ -n "$QUERY_STRING" ]; then
    SCRIPT=$(echo "$QUERY_STRING" | sed 's/^run=//')
    OUTPUT=$(/opt/web-scripts/"$SCRIPT".sh 2>&1)
    echo "<h2>Executed: $SCRIPT.sh</h2>"
    echo "<pre>$OUTPUT</pre>"
    echo "<a href=\"/cgi-bin/menu.cgi\">Back to menu</a>"
    exit 0
fi

# No script → show the menu
echo "<h2>Choose a script to run</h2>"
echo "<ul>"
echo "<li><a href=\"/cgi-bin/menu.cgi?run=config-crestron\">Configure Crestron</a></li>"
echo "<li>======</li>"
echo "<li><a href=\"/cgi-bin/menu.cgi?run=ptz01-power-on\">PTZ01 Power On</a></li>"
echo "<li><a href=\"/cgi-bin/menu.cgi?run=ptz01-power-standby\">PTZ01 Standby</a></li>"
echo "<li>======</li>"
echo "<li><a href=\"/cgi-bin/menu.cgi?run=ptz02-power-on\">PTZ02 Power On</a></li>"
echo "<li><a href=\"/cgi-bin/menu.cgi?run=ptz02-power-standby\">PTZ02 Standby</a></li>"
echo "<li>======</li>"
echo "<li><a href=\"/cgi-bin/menu.cgi?run=backup\">Run Backup</a></li>"
echo "<li><a href=\"/cgi-bin/menu.cgi?run=cleanup\">Cleanup logs</a></li>"
echo "<li><a href=\"/cgi-bin/menu.cgi?run=restart\">Restart service</a></li>"
echo "</ul>"
