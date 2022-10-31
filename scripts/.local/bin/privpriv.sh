#!/bin/sh
DISK=/dev/disk/by-uuid/f0b460c2-bfce-47c2-818e-8aacf1c9e31d
INNERDISK=/dev/disk/by-uuid/eb458541-29f6-4af1-9260-027f4c684f03

udisksctl unlock -b $DISK || exit $?
trap 'udisksctl lock -b $DISK || exit $?' EXIT
udisksctl mount -b $INNERDISK || exit $?
trap 'udisksctl unmount -b $INNERDISK || exit $?; udisksctl lock -b $DISK || exit $?' EXIT
fish --private -C 'cd /run/media/matt/sivydatni' || exit $?

