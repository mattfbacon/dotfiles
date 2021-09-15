#!/bin/sh
# should be 1 but wc somehow screws it up
if test "$(ps ax | grep '/home/matt/.local/bin/automic.sh' | grep -v 'grep' | wc -l)" -gt 2; then
	exit 0
fi
{
acpi_listen | while read -r event; do
	if [ "$event" = 'jack/headphone HEADPHONE plug' -o "$event" = 'jack/headphone HEADPHONE unplug' ]; then
		/home/matt/.local/bin/toggle-headset-mic.sh 2>/dev/null
	fi
done
} &
{
	while :; do
	/home/matt/.local/bin/toggle-headset-mic.sh 2>/dev/null
	sleep 3
done
}
