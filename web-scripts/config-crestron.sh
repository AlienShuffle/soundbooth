# SETVIDEOROUTE Make a Video connection
# SETAUDIOROUTE Make a Audio connection
# SETUSBROUTE Make a USB connection
# SETAVROUTE Make an Audio-Video connection
# SETAVUROUTE Make a Audio-Video-USB connection
# DUMPDMROUTEINFO dump all current routing info
# DUMPDMROUTEINFO n - dump routing for slot n
# MESS is an echo command
# SHOWHW is a detail hardware dump report
# BYE is logout gracefully
# REPORTDM Report port info (summarized here)
# input slots range 1-8
# output slots range 17-24
# This is configured to setup the CBC default configuration as of 2/9/2026
# Input 1 = ProPresenter PC
# Output 17-20 (1-4) = 3 Projectors and the Lobby LCD
(
    sleep 1
    # these early commands get eaten by the CLI for some reason and give errors.
    echo -ne "echo\r"
    sleep 1
    echo -ne "echo\r"
    sleep 1
    #echo -ne "reportdm\r"
    #sleep 1
    echo -ne "echo on\r"
    sleep 1
    echo -ne "mess Route 1 to 17-20\r"
    sleep 1
    echo -ne "setvideoroute 1 17-20\r"
    sleep 1
    #echo -ne "showhw\r"
    #sleep 1
    echo -ne "mess Route complete\r"
    sleep 2
    echo -ne "mess\r"
    sleep 1
    echo -ne "bye\r"
) |
    pv -qL 8 | nc -q 1 dmmd8x8.cbclocal 23
    # pv is used to slow down input to deal with slow telnet response on Crestron.
    # nc is netcat and sends the stream of echo's to the device on port 23.
    # -q 1 says to quit 1 second after the stream ends to help with a graceful shutdown of connection.
    # Note the Crestron DNS entry is hard-coded here and can be changed.
    # It was originally configure in the Unifi Network Manager for the CBC lan.
