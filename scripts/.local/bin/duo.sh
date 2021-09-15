#!/bin/sh
HOUR_SECS=3600
INTERVAL_SECS=$((3 * $HOUR_SECS))

echo move cursor to streak freeze button
sleep 5
while :; do
	echo press Ctrl+C to stop
	xdotool click 1
	sleep $(($INTERVAL_SECS / 2))
	xdotool key ctrl+r
	sleep $(($INTERVAL_SECS / 2))
done
