source ~/.setvars

export DESKTOP_SESSION=i3
export XDG_SESSION_DESKTOP="$DESKTOP_SESSION"
export XDG_CURRENT_DESKTOP="$DESKTOP_SESSION"
export SESSION="$DESKTOP_SESSION"
export MDMSESSION="$DESKTOP_SESSION"
export GDMSESSION="$DESKTOP_SESSION"

for f in /etc/X11/xinit/xinitrc.d/*.sh; do
	source "$f"
done

xrandr --dpi 192
xrandr --dpi 192
