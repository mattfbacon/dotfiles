function vps --wraps='ssh matt@myvps'
  ssh -t matt@felle.nz -- ~/sess.sh
end
