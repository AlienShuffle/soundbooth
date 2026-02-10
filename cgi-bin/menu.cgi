#!/bin/bash

echo "Content-type: text/html"
echo ""

# If a script name was submitted, run it with live output
if [ -n "$QUERY_STRING" ]; then
    SCRIPT=$(echo "$QUERY_STRING" | sed 's/^run=//')

    cat <<EOF
<html>
<head>
<title>Executing $SCRIPT</title>
<style>
    body { font-family: Arial, sans-serif; background: #f4f4f4; padding: 20px; }
    .container {
        background: #fff; max-width: 900px; margin: auto; padding: 25px;
        border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    pre {
        background: #eee; padding: 15px; white-space: pre-wrap;
        border-radius: 5px; font-size: 14px;
    }
    a.button {
        display: inline-block; margin-top: 20px; padding: 10px 15px;
        background: #0275d8; color: white; text-decoration: none;
        border-radius: 5px; font-weight: bold;
    }
    a.button:hover { background: #025aa5; }
</style>
</head>
<body>
<div class="container">
<h2>Running: $SCRIPT.sh</h2>
<pre>
EOF

    # Run the script and stream each line as it occurs
    stdbuf -o0 -e0 /opt/web-scripts/"$SCRIPT".sh 2>&1 | while IFS= read -r line; do
        echo "$line<br/>"
        echo
    done

    cat <<EOF
</pre>
<br/>
<a href="/cgi-bin/menu.cgi" class="button">Back to Menu</a>
</div>
</body>
</html>
EOF

    exit 0
fi


###########################
# MAIN MENU (STATIC HTML)
###########################

cat <<EOF
<html>
<head>
<title>Soundbooth</title>
<style>
    body { font-family: Arial, sans-serif; background: #eef1f5; padding: 20px; }
    .container {
        background: #fff; max-width: 1000px; margin: auto; padding: 30px;
        border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.12);
    }
    h1 { text-align: center; margin-bottom: 25px; color: #333; }

    .section-title {
        font-size: 22px; color: #444; margin-top: 30px;
        border-bottom: 2px solid #ddd; padding-bottom: 5px;
    }

    .button-grid {
        display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 12px; margin-top: 15px;
    }

    a.cmd-btn {
        display: block; padding: 12px; text-align: center;
        background: #0275d8; color: #fff; text-decoration: none;
        border-radius: 6px; font-weight: bold; font-size: 15px;
    }
    a.cmd-btn:hover { background: #025aa5; }
</style>
</head>

<body>
<div class="container">

<h1>CBC Soundbooth Control</h1>

<!-- SOUND BOOTH -->
<div class="section-title">Soundbooth (Crestron, Cameras, Projectors)</div>
<div class="button-grid">
    <a href="/cgi-bin/menu.cgi?run=initialize-soundbooth" class="cmd-btn">Initialize Soundbooth</a>
    <a href="/cgi-bin/menu.cgi?run=shutdown-soundbooth" class="cmd-btn">Shutdown Soundbooth</a>
    <a href="/cgi-bin/menu.cgi?run=config-crestron" class="cmd-btn">Configure Crestron</a>
</div>

<!-- PTZ CAMERAS -->
<div class="section-title">PTZ01 Camera</div>
<div class="button-grid">
    <a href="/cgi-bin/menu.cgi?run=ptz01-power-on" class="cmd-btn">PTZ01 Power On</a>
    <a href="/cgi-bin/menu.cgi?run=ptz01-power-standby" class="cmd-btn">PTZ01 Standby</a>
</div>
<div class="section-title">PTZ02 Camera</div>
<div class="button-grid">
    <a href="/cgi-bin/menu.cgi?run=ptz02-power-on" class="cmd-btn">PTZ02 Power On</a>
    <a href="/cgi-bin/menu.cgi?run=ptz02-power-standby" class="cmd-btn">PTZ02 Standby</a>
</div>

<!-- PROJECTORS LEFT -->
<div class="section-title">Projector - Left</div>
<div class="button-grid">
    <a href="/cgi-bin/menu.cgi?run=projector-left-power-on" class="cmd-btn">Power On</a>
    <a href="/cgi-bin/menu.cgi?run=projector-left-power-standby" class="cmd-btn">Standby</a>
    <a href="/cgi-bin/menu.cgi?run=projector-left-power-query" class="cmd-btn">Power Query</a>
</div>

<!-- PROJECTORS RIGHT -->
<div class="section-title">Projector - Right</div>
<div class="button-grid">
    <a href="/cgi-bin/menu.cgi?run=projector-right-power-on" class="cmd-btn">Power On</a>
    <a href="/cgi-bin/menu.cgi?run=projector-right-power-standby" class="cmd-btn">Standby</a>
    <a href="/cgi-bin/menu.cgi?run=projector-right-power-query" class="cmd-btn">Power Query</a>
</div>

<!-- PROJECTORS REAR -->
<div class="section-title">Projector - Rear</div>
<div class="button-grid">
    <a href="/cgi-bin/menu.cgi?run=projector-rear-power-on" class="cmd-btn">Power On</a>
    <a href="/cgi-bin/menu.cgi?run=projector-rear-power-standby" class="cmd-btn">Standby</a>
    <a href="/cgi-bin/menu.cgi?run=projector-rear-power-query" class="cmd-btn">Power Query</a>
</div>


<!-- MAINTENANCE -->
<div class="section-title">Maintenance</div>
<div class="button-grid">
    <a href="/cgi-bin/menu.cgi?run=backup" class="cmd-btn">Run Backup</a>
    <a href="/cgi-bin/menu.cgi?run=cleanup" class="cmd-btn">Cleanup Logs</a>
    <a href="/cgi-bin/menu.cgi?run=restart" class="cmd-btn">Restart Service</a>
</div>
</div>
</body>
</html>
EOF
