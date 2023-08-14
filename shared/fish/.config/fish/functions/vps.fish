function vps --wraps='ssh matt@myvps'
  ssh -p 21149 -t matt@felle.nz -- ~/sess.sh
end
