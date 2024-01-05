#!/bin/sh

PROFILE=""
case "$1" in
	home)
		PROFILE="3k9z7b16.default"
	;;
	school)
		PROFILE="m8tvww85.School"
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
