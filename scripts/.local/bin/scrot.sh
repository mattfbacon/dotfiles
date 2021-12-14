#!/bin/sh
TYPE="$(echo -e 'screen\narea' | bemenu)"

case "$TYPE" in
	screen)
		grim
		;;
	area)
		grim -g "$(slurp)"
		;;
	*)
		exit 1
		;;
esac
