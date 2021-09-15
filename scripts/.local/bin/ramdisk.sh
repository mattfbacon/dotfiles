#!/bin/sh
test -z "$1" && echo 'please provide size in mb' || sudo mount -t tmpfs -o size=$1m tmpfs /media/matt/ramdisk
