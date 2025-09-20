#!/bin/sh

mode() {
	tlp-stat -s | rg 'Mode\s*=\s*(\w+).*$' -r '$1'
}

cmd=""
case "$1" in
	switch)
		case "$(mode)" in
			battery)
				sudo tlp ac
				;;
			AC)
				sudo tlp bat
				;;
		esac
		;;
	*)
		;;
esac

icon="=="
if [ "$(mode)" = AC ]; then
	icon="!!"
fi

echo "$icon"
