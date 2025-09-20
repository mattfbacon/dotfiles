#!/bin/sh
HOUR="$(date +'%H')"
if [ "$#" -ne 0 ]; then
	THEME="$1"
else
	if [ "${HOUR}" -ge 20 -o "${HOUR}" -lt 8 ]; then
		THEME=dark
	else
		THEME=light
	fi
fi

gsettings set org.gnome.desktop.interface color-scheme "prefer-${THEME}"

ln -srf ~/.config/alacritty/{"${THEME}",theme}.toml
# Make alacritty reload config.
touch ~/.config/alacritty/alacritty.toml

ln -srf ~/.config/sway/theme{."${THEME}",}.conf
ln -srf ~/.config/waybar/style{."${THEME}",}.css
# TODO: Possible to just change the colors in sway without a full reload?
swaymsg reload
