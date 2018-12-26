#!/usr/bin/env bash

if [ x"$@" = x"Quit" ]
then
    exit 0
fi

if [ "$@" ]
then
    case "$@" in
	"Lock Screen") coproc ($HOME/.config/awesome/scripts/locker.sh > /dev/null) ;;
	"Suspend") coproc (systemctl suspend > /dev/null) ;;
 	"Hibernate") coproc (systemctl hibernate > /dev/null) ;;
	"Reboot") coproc (systemctl reboot > /dev/null);;
	"Power Off") coproc (systemctl poweroff > /dev/null);;
	"arandr") coproc (arandr > /dev/null);;
	"Monitor Off") coproc (xrandr --output HDMI1 --off > /dev/null);;
	"Monitor On") coproc (xrandr --output HDMI1 --auto > /dev/null);;
	"scr-layout") coproc ($HOME/.screenlayout/main.sh > /dev/null);;
    esac
    exit 0
else
    echo -en "\x00prompt\x1POWER\n"
    echo -en "\0urgent\x1f1,1\n"
    echo -en "\0urgent\x1f1,6\n"
    echo -en "\0urgent\x1f1,7\n"
    echo -en "\0urgent\x1f1,8\n"
    echo -en "\0active\x1f1\n"
    echo -en "\0markup-rows\x1ftrue\n"
   # echo -en "\0message\x1fSpecial <b>bold</b>message\n"
    echo "Lock Screen"
    echo "Suspend"
    echo "Monitor Off"
    echo "Monitor On"
    echo "arandr"
    echo "scr-layout"
    echo "Hibernate"
    echo "Reboot"
    echo "Power Off"
   #  echo "<b>Awesome restart</b>"
    echo "Quit"
fi
