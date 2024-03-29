#
# ~/.config/fish/config.fish
#

pyenv init - | source

status --is-interactive; or exit

[ (basename (cat "/proc/"(ps -o ppid -p $fish_pid | sed '2q;d' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"/comm")) != electron ]; and not set -q fish_private_mode; and mfetch &

alias m='d m'

pyenv init --path | source
zoxide init fish | source
alias z=zi

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

source /usr/share/doc/find-the-command/ftc.fish

set -g fish_handle_reflow 1

