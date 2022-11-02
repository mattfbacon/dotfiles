#!/bin/sh
mkdir -p /media/${USER}/ramdisk
test -z "$1" && echo 'please provide size in mb' || doas mount -t tmpfs -o size=$1m tmpfs /media/${USER}/ramdisk
