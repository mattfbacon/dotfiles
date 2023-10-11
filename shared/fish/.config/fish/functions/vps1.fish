function vps1 --wraps='ssh matt@myvps'
  ssh -p 21149 -t matt@vps1.felle.nz -- ~/sess.sh
end
