#!/bin/sh
HOUR="$(date +'%H')"
if [ "${HOUR}" -ge 21 -o "${HOUR}" -le 8 ]; then
	THEME=prefer-dark
else
	THEME=default
fi
gsettings set org.gnome.desktop.interface color-scheme "${THEME}"
