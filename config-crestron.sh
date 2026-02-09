# SETVIDEOROUTE Make a Video connection
# SETAUDIOROUTE Make a Audio connection
# SETUSBROUTE Make a USB connection
# SETAVROUTE Make an Audio-Video connection
# SETAVUROUTE Make a Audio-Video-USB connection
# DUMPDMROUTEINFO
# inputs range 1-8
# outputs range 17-24
# This is configured to setup the CBC default configuration
# Input 1 = ProPresenter PC
# Output 17-20 (1-4) = 3 Projectors and the Lobby LCD
(
    sleep 1
    echo -ne "echo off\r\n"
    sleep 1
    echo -ne "mess Route 1 to 17-20\r\n"
    sleep 1
    echo -ne "setvideoroute 1 17-20\r\n"
    sleep 1
    echo -ne "showhw\r\n"
    sleep 1
    echo -ne "mess Route complete\r\n"
    sleep 2
    echo -ne "mess\r\n"
    sleep 1
    echo -ne "bye\r\n"
) |
    pv -qL 5 |
    tee |
    telnet dmmd8x8.cbclocal
