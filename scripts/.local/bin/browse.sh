#!/bin/sh

PROFILE_DIR="$1"

case "$PROFILE_DIR" in
	school)
		PROFILE_DIR="Profile 3"
		;;
	home)
		PROFILE_DIR="Profile 2"
		;;
	college)
		PROFILE_DIR="Profile 1"
		;;
	*)
		echo "Invalid profile dir $PROFILE_DIR" >&2
		exit 1
		;;
esac

shift

exec brave --enable-features=UseOzonePlatform,WebRTCPipeWireCapture --ozone-platform=wayland --profile-directory="$PROFILE_DIR" $@
