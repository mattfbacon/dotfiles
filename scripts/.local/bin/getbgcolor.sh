#!/bin/sh
echo -n $1
awk '/^[^#].+$/ { print $1; exit }' /home/matt/.config/bgcolor
