#!/bin/sh
revert() {
	dunstctl set-paused false
	xset dpms 180 180 180
}
trap revert HUP INT TERM
xset dpms 5 5 5
dunstctl set-paused true
i3lock -nefc "$(getbgcolor.sh)"
revert
