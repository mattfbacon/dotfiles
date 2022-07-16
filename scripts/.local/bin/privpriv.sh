#!/bin/sh
udisksctl unlock -b /dev/disk/by-uuid/08fcb094-3917-427b-af9c-05415e8d060c || exit $?
trap 'udisksctl lock -b /dev/disk/by-uuid/08fcb094-3917-427b-af9c-05415e8d060c || exit $?' EXIT
udisksctl mount -b /dev/disk/by-uuid/2a8b0782-8a64-4957-b033-81b5e23fc321 || exit $?
trap 'udisksctl unmount -b /dev/disk/by-uuid/2a8b0782-8a64-4957-b033-81b5e23fc321 || exit $?; udisksctl lock -b /dev/disk/by-uuid/08fcb094-3917-427b-af9c-05415e8d060c || exit $?' EXIT
fish --private -C 'cd /run/media/matt/predatni' || exit $?

