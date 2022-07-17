#!/bin/sh
BACKGROUND="$(find ~/Pictures/Wallpapers -type f | shuf | head -n1)"
feh --bg-fill "$BACKGROUND"
