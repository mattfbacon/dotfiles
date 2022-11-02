function fish_right_prompt
  set -l last_pipestatus $pipestatus
  __fish_print_pipestatus "[" "]" "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus
	set -q fish_private_mode; and set_color -do black; and echo " ﴣ "; and set_color normal
end
