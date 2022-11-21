function fish_prompt
	set -q fish_private_mode; and set_color -b black && set_color FFF; or set_color blue
	if [ $TERM != "linux" ]
		echo -n "⋊⋗!"
	else
		echo -n "fish!"
	end
	set_color normal
	set_color -o cyan
	echo -n (whoami)
	set_color normal
	echo -n " "
	set_color green
	test (whoami) = root; and echo -n (pwd 2>/dev/null | sed "s/^\/root/~/"); or echo -n (pwd 2>/dev/null | sed "s/^\/home\/"(whoami)"/~/")
	set_color normal
	fish_git_prompt ^/dev/null

	test $USER = 'root'; and echo -n " \# "; or echo -n " \$ "
end
