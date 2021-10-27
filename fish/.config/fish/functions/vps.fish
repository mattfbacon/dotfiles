function vps --wraps='ssh matt@myvps' --description 'alias vps=ssh matt@myvps'
  ssh matt@myvps $argv; 
end
