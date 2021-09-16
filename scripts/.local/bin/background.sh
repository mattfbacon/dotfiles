#!/bin/sh
bg=$(xrdb -query | grep -E '^i3.Background:' | cut -f2)
feh --bg-fill ~/$bg
