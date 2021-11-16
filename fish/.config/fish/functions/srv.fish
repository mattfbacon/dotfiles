function srv --wraps='ssh support@mynfs -p 69'
  mosh --ssh="ssh -p 69" support@mynfs -- sh -c 'tmux has-session -t 0 && tmux attach -t 0 -d || tmux'
end
