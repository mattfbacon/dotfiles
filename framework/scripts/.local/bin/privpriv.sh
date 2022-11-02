#!/bin/sh
DISK=/dev/disk/by-uuid/a02adf15-769d-4b61-9122-ddb3b3d1e7c2
INNERDISK=/dev/disk/by-uuid/ac80428f-f91d-4b99-9d40-c885d122be18

udisksctl unlock -b $DISK || exit $?
trap 'udisksctl lock -b $DISK || exit $?' EXIT
udisksctl mount -b $INNERDISK || exit $?
trap 'udisksctl unmount -b $INNERDISK || exit $?; udisksctl lock -b $DISK || exit $?' EXIT
fish --private -C 'cd /run/media/matt/sivydatni' || exit $?

