#
# ~/.config/fish/config.fish
#

set -p PATH ~/.local/bin

pyenv init - | source

status --is-interactive; or exit

pyenv init --path | source

set -a fish_complete_path /usr/local/share/fish/vendor_completions.d

#if test -f ~/.ssh/agent.env
#  . ~/.ssh/agent.env > /dev/null
#  if ! kill -0 -- $SSH_AGENT_PID > /dev/null 2>/dev/null
#    eval (ssh-agent -c | tee ~/.ssh/agent.env)
#    ssh-add
#  end
#else
#  eval (ssh-agent -c | tee ~/.ssh/agent.env)
#  ssh-add
#end

if [ $TERM != linux ] && [ $TERM != screen ]
    starship init fish | source
end

fish_user_keybindings

set -g fish_handle_reflow 1

[ (basename (cat "/proc/"(ps -o ppid -p $fish_pid | sed '2q;d' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"/comm")) != electron ]; and not set -q fish_private_mode; and mfetch
