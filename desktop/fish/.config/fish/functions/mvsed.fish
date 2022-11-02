function mvsed
	set -l files $argv[2..-1]
	for f in $files
		mv $f (echo $f | sed $argv[1])
	end
end
