#!/bin/sh
ecryptfs-mount-private
fish --private -C 'cd ~/Private'
ecryptfs-umount-private
