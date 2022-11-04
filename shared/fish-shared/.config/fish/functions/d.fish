function d -a op disk
	function matches -a pat arg
		string match $arg'*' $pat >/dev/null
	end

	test -z $op; and begin; echo 'missing operation' >&2; return 1; end
	test -z $disk; and begin; echo 'missing disk' >&2; return 1; end

	if matches mount $op
		set op mount
	else if matches unmount $op; or matches umount $op
		set op unmount
	else if matches cd $op; or matches goto $op
		set op cd
	else
		echo 'invalid operation. expected mount, unmount/umount, goto/cd.' >&2
		return 1
	end

	if matches zdani $disk
		set disk zdani
	else if matches sivydatni $disk
		set disk sivydatni
	else if matches muhackiku $disk
		set disk muhackiku
	else if matches barda $disk
		set disk barda
	else
		echo 'invalid disk. expected zdani, sivydatni, muhackiku, barda.' >&2
		return 1
	end

	set mounted_path "/run/media/$USER/$disk"

	if test $op = cd
		if not test -e $mounted_path
			d mount $disk
		end
		cd $mounted_path
		return
	end

	if test $op = unmount; and matches $mounted_path'*' (pwd)
		cd ~
	end

	switch $disk
		case zdani barda
			udisksctl $op -b /dev/disk/by-label/$disk
			return
		case sivydatni
			set uuid a02adf15-769d-4b61-9122-ddb3b3d1e7c2
			set inner_uuid ac80428f-f91d-4b99-9d40-c885d122be18
		case muhackiku
			set uuid 809dbaf9-4c95-4baf-890c-e6866dd1a913
			set inner_uuid e1258f59-cb99-4b6b-8bd7-513c66d64439
	end

	switch $op
		case mount
			udisksctl unlock -b /dev/disk/by-uuid/$uuid
			udisksctl mount -b /dev/disk/by-uuid/$inner_uuid
		case unmount
			udisksctl unmount -b /dev/disk/by-uuid/$inner_uuid
			udisksctl lock -b /dev/disk/by-uuid/$uuid
	end
end
