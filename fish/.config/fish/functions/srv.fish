function srv --wraps='ssh support@mynfs -p 69'
  mosh --ssh="ssh -p 69" support@mynfs -- sh -c 'SESS=$(tmux list-sessions | grep -v attached | head -1 | cut -d':' -f1); test -n "$SESS" && tmux attach -t "$SESS" -d || tmux'
end
