#!/bin/sh
if test -z $1; then
  echo 'Usage: cleancomputer.sh <time to disable>'
  exit 1
fi
INPUTS=$(xinput --list | awk -F'\t' 'BEGIN{IGNORECASE=1};/(AT Translated Set 2 keyboard|touchpad|finger).+slave/ { print $2 }' | cut -d'=' -f2)
for dv in $INPUTS; do
  xinput disable $dv
done
sleep $(($1 - 3))
for i in $(seq 3 -1 1); do
  echo 'reenabling in '$i
  sleep 1
done
for dv in $INPUTS; do
  xinput enable $dv
done
