#!/bin/sh
revert() {
	dunstctl set-paused false
	xset dpms 0 0 0
}
trap revert HUP INT TERM
xset +dpms dpms 5 5 5
dunstctl set-paused true
i3lock -nefc "$(getbgcolor.sh)"
revert
