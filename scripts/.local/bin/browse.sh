#!/bin/sh

PROFILE=""
case "$1" in
	home)
		PROFILE="5bmfmi8v.Home"
	;;
	school)
		PROFILE="0td0hysr.School"
	;;
	college)
		PROFILE="mh4f9c7h.College"
	;;
	*)
		echo 'Unknown profile' >&2
		exit 1
	;;
esac
shift

ARGS=""
case "$1" in
	normal)
		ARGS=""
	;;
	tab)
		ARGS="--new-tab"
	;;
	window)
		ARGS="--new-window"
	;;
	browse)
		ARGS="--browser"
	;;
	private)
		ARGS="--private-window"
	;;
	*)
		echo 'Unknown browser type' >&2
		exit 1
	;;
esac
shift

exec firefox --profile "$HOME/.mozilla/firefox/$PROFILE" $ARGS "$@"
