function vps2 --wraps='ssh matt@vps2.felle.nz'
  ssh -p 21149 -t matt@vps2.felle.nz -- ~/sess.sh
end
