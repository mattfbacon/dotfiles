function srv --wraps='ssh support@mynfs -p 69'
  mosh --ssh="ssh -p 69" support@ark.mattfellenz.be
end
