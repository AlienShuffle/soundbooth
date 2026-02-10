# SETVIDEOROUTE Make a Video connection
# SETAUDIOROUTE Make a Audio connection
# SETUSBROUTE Make a USB connection
# SETAVROUTE Make an Audio-Video connection
# SETAVUROUTE Make a Audio-Video-USB connection
# DUMPDMROUTEINFO dump all current routing info
# DUMPDMROUTEINFO n - dump routing for slot n
# REPORTDM Report port info (summarized here)
# input slots range 1-8
# output slots range 17-24
# This is configured to setup the CBC default configuration as of 2/9/2026
# Input 1 = ProPresenter PC
# Output 17-20 (1-4) = 3 Projectors and the Lobby LCD
(
    sleep 1
    # these early commands get eaten by the CLI for some reason and gives error.
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
    pv -qL 8 |
    telnet dmmd8x8.cbclocal
    # alternative is nc, needs to be tested.
    # nc -N -w2 dmmd8x8.cbclocal 23 
