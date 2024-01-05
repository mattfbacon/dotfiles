#!/bin/sh

PROFILE=""
case "$1" in
	home)
		PROFILE="st2fjblt.Home"
	;;
	school)
		PROFILE="l4xgjvs4.College"
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

exec firefox-developer-edition --profile "$HOME/.mozilla/firefox/$PROFILE" $ARGS "$@"
