function vps --wraps='ssh matt@myvps'
  mosh matt@mattfellenz.be -- sh -c 'SESS=$(tmux list-sessions | grep -v attached | head -1 | cut -d':' -f1); test -n "$SESS" && tmux attach -t "$SESS" -d || tmux'
end
