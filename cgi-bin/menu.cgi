#!/bin/bash

echo "Content-type: text/html"
echo ""

# If a script name was submitted, run it
if [ -n "$QUERY_STRING" ]; then
    SCRIPT=$(echo "$QUERY_STRING" | sed 's/^run=//')
    OUTPUT=$("/opt/web-scripts/$SCRIPT.sh" 2>&1)

    cat <<EOF
<html>
<head>
<title>Command Execution</title>
<style>
    body { font-family: Arial, sans-serif; background: #f4f4f4; padding: 20px; }
    .container { background: white; padding: 20px; margin: auto; border-radius: 8px; max-width: 800px; }
    h2 { color: #333; }
    pre { background: #eee; padding: 15px; border-radius: 5px; white-space: pre-wrap; }
    a.button {
        display: inline-block; padding: 10px 15px; margin-top: 20px;
        background: #0275d8; color: white; border-radius: 4px; text-decoration: none;
    }
    a.button:hover { background: #025aa5; }
</style>
</head>
<body>
<div class="container">
<h2>Executed: $SCRIPT.sh</h2>
<pre>$OUTPUT</pre>
/cgi-bin/menu.cgiBack to Menu</a>
</div>
</body>
</html>
EOF
    exit 0
fi

# Otherwise show the pretty menu
cat <<EOF
<html>
<head>
<title>System Control Menu</title>
<style>
    body { font-family: Arial, sans-serif; background: #eef1f5; padding: 20px; }
    .container { max-width: 900px; margin: auto; background: white; padding: 30px;
                 border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }

    h1 { text-align: center; color: #333; margin-bottom: 30px; }

    .section-title {
        font-size: 20px; margin-top: 25px; color: #444;
        border-bottom: 2px solid #ddd; padding-bottom: 5px;
    }

    .button-grid {
        display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 10px; margin-top: 15px;
    }

    a.cmd-btn {
        display: block; padding: 12px; background: #0275d8; color: white;
        text-decoration: none; border-radius: 6px; text-align: center;
        font-weight: bold; transition: 0.2s;
    }

    a.cmd-btn:hover { background: #025aa5; }
</style>
</head>
<body>
<div class="container">
<h1>System Control Menu</h1>

<div class="section-title">Soundbooth</div>
<div class="button-grid">
    /cgi-bin/menu.cgi?run=initial-soundboothInitialize Soundbooth</a>
    /cgi-bin/menu.cgi?run=shutdown-soundboothShutdown Soundbooth</a>
    /cgi-bin/menu.cgi?run=config-crestronConfigure Crestron</a>
</div>

<div class="section-title">PTZ Cameras</div>
<div class="button-grid">
    /cgi-bin/menu.cgi?run=ptz01-power-onPTZ01 Power On</a>
    /cgi-bin/menu.cgi?run=ptz01-power-standbyPTZ01 Standby</a>
    /cgi-bin/menu.cgi?run=ptz02-power-onPTZ02 Power On</a>
    /cgi-bin/menu.cgi?run=ptz02-power-standbyPTZ02 Standby</a>
</div>

<div class="section-title">Projector - Right</div>
<div class="button-grid">
    /cgi-bin/menu.cgi?run=projector-right-power-onPower On</a>
    /cgi-bin/menu.cgi?run=projector-right-power-standbyStandby</a>
    /cgi-bin/menu.cgi?run=projector-right-power-queryPower Query</a>
</div>

<div class="section-title">Projector - Rear</div>
<div class="button-grid">
    /cgi-bin/menu.cgi?run=projector-rear-power-onPower On</a>
    /cgi-bin/menu.cgi?run=projector-rear-power-standbyStandby</a>
    /cgi-bin/menu.cgi?run=projector-rear-power-queryPower Query</a>
</div>

<div class="section-title">Projector - Left</div>
<div class="button-grid">
    /cgi-bin/menu.cgi?run=projector-left-power-onPower On</a>
    /cgi-bin/menu.cgi?run=projector-left-power-standbyStandby</a>
    /cgi-bin/menu.cgi?run=projector-left-power-queryPower Query</a>
</div>

<div class="section-title">Maintenance</div>
<div class="button-grid">
    /cgi-bin/menu.cgi?run=backupRun Backup</a>
    /cgi-bin/menu.cgi?run=cleanupCleanup Logs</a>
    /cgi-bin/menu.cgi?run=restartRestart Service</a>
</div>

</div>
</body>
</html>
EOF
