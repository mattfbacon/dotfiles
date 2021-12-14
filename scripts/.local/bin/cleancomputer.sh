#!/bin/sh
if test -z $1; then
  echo 'Usage: cleancomputer.sh <time to disable>'
  exit 1
fi
swaymsg input '*' events disabled
swaymsg input '*' events disabled
swaymsg input '*' events disabled
swaymsg input '*' events disabled
sleep $(($1 - 3))
for i in $(seq 3 -1 1); do
  echo 'reenabling in '$i
  sleep 1
done
swaymsg input '*' events enabled
swaymsg input '*' events enabled
swaymsg input '*' events enabled
swaymsg input '*' events enabled
