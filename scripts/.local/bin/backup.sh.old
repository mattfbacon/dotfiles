#!/bin/sh
if cat /proc/mounts | grep -q /media/matt/nfs
then
	:
else
	echo 'Mount NFS'; exit 1
fi
duplicity --exclude /home/matt/Music --exclude /home/matt/.deja-dup --exclude /home/matt/Documents/ISOs /home/matt file:///media/matt/nfs/backup/
