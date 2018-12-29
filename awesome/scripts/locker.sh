#!/usr/bin/env bash
# Time-stamp: <Last changed 2018-07-09 09:40:46>
#depends: imagemagick, i3lock, scrot, socat(for mpv), libnotify-bin (for notification)
#executed by xautolock
#
################################################################################

# Variables --------------------------------------------------------------------

TMPBG="$HOME/.local/tmp/screen.png"
CONDITION=0

# image prepare ----------------------------------------------------------------

lock_image(){
    local icon="$HOME/.config/awesome/themes/icons/std/lock.png"   # locker icon on screen center
    local ltext="$HOME/.local/tmp/locktext.png"
    scrot $TMPBG
    convert $TMPBG -scale 25% -scale 400% -fill black -colorize 25% $TMPBG
    if [ ! -f $ltext ]; then 
	convert -size 3000x80 xc:white -font DejaVu-Sans-Mono-Bold -pointsize 56 -fill black -gravity center -annotate +0+0 'Type password to unlock' $ltext
	convert $ltext -alpha set -channel A -evaluate set 50% $ltext
    fi
    convert $TMPBG $ltext -gravity center -geometry +0+200 -composite $TMPBG
    convert $TMPBG $icon -gravity center -composite -matte $TMPBG
}

# error message as notification ------------------------------------------------

show_error(){
    local err_icon="$HOME/.config/awesome/themes/icons/96x96/dialog-error.svg"
    local message=$1
    notify-send -i $err_icon -u normal "i3lock ошибка!" "$message"
}

# check status i3lock ----------------------------------------------------------

check_i3lock(){
    case $(pgrep -c i3lock) in
	0) let "CONDITION += 0";;
	1) exit 0;;
	*) let "CONDITION +=100";;
    esac
}

# check status of mpv, if run and not paused then do not lock screen -----------

check_mpv(){
    if [ $(pgrep -c mpv) = 0 ]; then
		let "CONDITION += 0"
    else
	case $(echo '{ "command": ["get_property", "pause"] }' | socat - /tmp/mpvsocket | awk 'BEGIN { FS="{|:|," }{ print $3 }') in
	    false) let "CONDITION += 1";;
	    true) let "CONDITION += 0";;
	    *) let "CONDITION +=10";;
	esac
    fi
}

# chek status i3lock, if not run, then ... -------------------------------------

check_i3lock
check_mpv
if [ $CONDITION -eq 0 ]; then
    lock_image
    i3lock -ni "$TMPBG"
else
    if [ $CONDITION -ge 100 ]; then
        show_error "i3lock процессов запущено: $(pgrep -c i3lock),\n все процессы будут закрыты!"
	killall i3lock
    elif [ $CONDITION -ge 10 ]
    then 
	show_error "Проверка статуса mpv вернула ошибку!"
    fi
fi
exit 0

# EOF
