alias ga='git add'
alias gap='git add -p'
alias gc='git commit'
alias gcan='git commit --amend --no-edit'
alias gck='git checkout'
alias gcm='git commit -m'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log'
alias grs='git restore --staged'
alias gs='git status'
alias gst='git stash'
alias gp='git push'
alias gpu='git pull'

alias cr='cargo run'

alias cat='bat'
alias ls='exa -a --header --git --grid --classify --group'
alias lstree='ls -T' # uses previous
alias vim='nvim'

alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'

alias wget='wget -c'
alias curl='curl -L'

set -l numcpus (nproc)
alias make="time nice make -j$numcpus --load-average=$numcpus"

alias jo='journalctl'
alias jou='journalctl --user'
alias sy='systemctl'
alias ssy='doas systemctl'
alias syu='systemctl --user'

alias c='rlwrap rpni'

alias off='systemctl poweroff'
