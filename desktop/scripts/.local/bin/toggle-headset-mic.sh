#!/bin/sh
SOURCE_NUM=`pactl list sources short | grep 'pci-' | grep -v monitor | cut -f 1`
SINK_NUM=`pactl list sinks short | grep 'pci-' | grep -v monitor | cut -f 1`
# ↓ if headphones are not plugged in
if pactl list sinks | grep analog-output-headphones | grep 'not available' -q
then
	pactl set-source-port $SOURCE_NUM 'analog-input-internal-mic'
	pactl set-sink-port $SINK_NUM 'analog-output-speaker'
	pactl set-source-volume $SOURCE_NUM '29%'
else
	pactl set-source-port $SOURCE_NUM 'analog-input-headset-mic'
	pactl set-sink-port $SINK_NUM 'analog-output-headphones'
	pactl set-source-volume $SOURCE_NUM '40%'
fi
