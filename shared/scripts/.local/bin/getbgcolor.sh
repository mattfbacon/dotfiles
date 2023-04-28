#!/bin/sh
bg=$(xrdb -query | grep -E '^i3.Background.color:' | cut -f2)
echo -n $1
echo $bg | sed 's/^#//'
