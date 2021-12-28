#!/bin/sh

default_location() {
	echo ~/Pictures/grim_"$(date +%F_%H-%M-%S)".png
}

TYPE="$(echo -e 'screen\narea' | bemenu -p Type)"
OUTPUT="$(echo -e 'file\nclipboard' | bemenu -p Output)"

REGION=""
test "$TYPE" = area && REGION="$(slurp)"

case "$OUTPUT" in
	file)
		grim ${REGION:+-g "$REGION"} "$(default_location | bemenu -p Location)"
		;;
	clipboard)
		grim ${REGION:+-g "$REGION"} - | wl-copy -t image/png
		;;
	*)
		exit 1
		;;
esac
