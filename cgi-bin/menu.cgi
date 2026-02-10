#!/bin/bash

echo "Content-type: text/html"
echo ""

# --- Handle script execution ---
if [ -n "$QUERY_STRING" ]; then
    SCRIPT=$(echo "$QUERY_STRING" | sed 's/^run=//')
    OUTPUT=$("/opt/web-scripts/$SCRIPT.sh" 2>&1)

    cat <<EOF
<html>
<head>
<title>Command Execution</title>
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
    <h2>Executed: $SCRIPT.sh</h2>
    <pre>$OUTPUT</pre>
    /cgi-bin/menu.cgiBack to Menu</a>
</div>
</body>
</html>
EOF
    exit 0
fi

# --- Otherwise show menu ---
cat <<EOF
<html>
<head>
<title>System Control Menu</title>
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
<div class="section-title">Soundbooth</div>
<div class="button-grid">
    /cgi-bin/menu.cgi?run=initial-soundboothInitialize Soundbooth</a>
    /cgi-bin/menu.cgi?run=shutdown-soundboothShutdown Soundbooth</a>
    /cgi-bin/menu.cgi?run=config-crestronConfigure Crestron</a>
</div>

<!-- PTZ CAMERAS -->
<div class="section-title">PTZ Cameras</div>
<div class="button-grid">
    /cgi-bin/menu.cgi?run=ptz01-power-onPTZ01 Power On</a>
    /cgi-bin/menu.cgi?run=ptz01-power-standbyPTZ01 Standby</a>
    /cgi-bin/menu.cgi?run=ptz02-power-onPTZ02 Power On</a>
    /cgi-bin/menu.cgi?run=ptz02-power-standbyPTZ02 Standby</a>
</div>

<!-- PROJECTORS LEFT -->
<div class="section-title">Projector – Left</div>
<div class="button-grid">
    /cgi-bin/menu.cgi?run=projector-left-power-onPower On</a>
    /cgi-bin/menu.cgi?run=projector-left-power-standbyStandby</a>
    /cgi-bin/menu.cgi?run=projector-left-power-queryPower Query</a>
</div>

<!-- PROJECTORS RIGHT -->
<div class="section-title">Projector – Right</div>
<div class="button-grid">
    /cgi-bin/menu.cgi?run=projector-right-power-onPower On</a>
    /cgi-bin/menu.cgi?run=projector-right-power-standbyStandby</a>
    /cgi-bin/menu.cgi?run=projector-right-power-queryPower Query</a>
</div>

<!-- PROJECTORS REAR -->
<div class="section-title">Projector – Rear</div>
<div class="button-grid">
    /cgi-bin/menu.cgi?run=projector-rear-power-onPower On</a>
    /cgi-bin/menu.cgi?run=projector-rear-power-standbyStandby</a>
    /cgi-bin/menu.cgi?run=projector-rear-power-queryPower Query</a>
</div>



<!-- MAINTENANCE -->
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
