#!/usr/bin/env bash
# simple power-off menu for rofy modi
# Version: 07-07-2018 10:43 MSK
#############################################

if [ x"$@" = x"Quit" ]
then
    exit 0
fi

if [ "$@" ]
then
    case "$@" in
	"Lock Computer") coproc ($HOME/.config/awesome/scripts/locker.sh > /dev/null) ;;
	"Suspend Computer") coproc (systemctl suspend > /dev/null) ;;
 	"Hibernate Computer") coproc (systemctl hibernate > /dev/null) ;;
	"Reboot Computer") coproc (systemctl reboot > /dev/null);;
	"Power Off") coproc (systemctl poweroff > /dev/null);;
	"arandr") coproc (arandr > /dev/null);;
	"MonOff") coproc (xrandr --output HDMI1 --off > /dev/null);;
	"MonOn") coproc (xrandr --output HDMI1 --auto > /dev/null);;
	"scr-layout") coproc ($HOME/.screenlayout/main.sh > /dev/null);;
    esac
    exit 0
else
    echo -en "\x00prompt\x1POWER\n"
    echo -en "\0urgent\x1f1,1\n"
    echo -en "\0urgent\x1f3,1\n"
    echo -en "\0urgent\x1f4,1\n"
    echo -en "\0urgent\x1f5,1\n"
    echo -en "\0active\x1f1\n"
    echo -en "\0markup-rows\x1ftrue\n"
    # echo -en "\0message\x1fSpecial <b>bold</b>message\n"
    echo "Lock Computer"
    echo "Suspend Computer"
    #    echo "MonOff"
    #    echo "MonOn"
    echo "arandr"
    #    echo "scr-layout"
    echo "Hibernate Computer"
    echo "Reboot Computer"
    echo "Power Off"
    #  echo "<b>Awesome restart</b>"
    echo "Quit"
fi