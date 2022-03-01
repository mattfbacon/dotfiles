#!/bin/sh

PROFILE_DIR="$1"

case "$PROFILE_DIR" in
	school)
		# PROFILE_DIR="Profile 3"
		PROFILE_DIR="0td0hysr.School"
		;;
	home)
		# PROFILE_DIR="Profile 2"
		PROFILE_DIR="5bmfmi8v.Home"
		;;
	college)
		# PROFILE_DIR="Profile 1"
		PROFILE_DIR="mh4f9c7h.College"
		;;
	*)
		echo "Invalid profile dir $PROFILE_DIR" >&2
		exit 1
		;;
esac

PROFILE_DIR=~/.mozilla/firefox/"$PROFILE_DIR"
shift

# exec brave --enable-features=UseOzonePlatform,WebRTCPipeWireCapture --ozone-platform=wayland --profile-directory="$PROFILE_DIR" $@
exec firefox --profile "$PROFILE_DIR" $@
