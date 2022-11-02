function srv --wraps='ssh matt@mc.matt.felle.nz'
  mosh matt@mc.matt.felle.nz -- sh -c 'SESS=$(tmux list-sessions | grep -v attached | head -1 | cut -d':' -f1); test -n "$SESS" && tmux attach -t "$SESS" -d || tmux'
end
