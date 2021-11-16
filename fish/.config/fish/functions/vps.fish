function vps --wraps='ssh matt@myvps'
  mosh matt@mattfellenz.be -- sh -c 'tmux has-session -t 0 && tmux attach -t 0 -d || tmux'
end
