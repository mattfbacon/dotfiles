local function bind(context, outer_opts)
	outer_opts = outer_opts or { noremap = true }
	return function (from, to, opts)
		opts = vim.tbl_extend('force', outer_opts, opts or {})
		vim.keymap.set(context, from, to, opts)
	end
end

return {
	n_re    = bind('n', { noremap = false }),
	n_no_re = bind 'n',
	v_no_re = bind 'v',
	x_no_re = bind 'x',
	i_no_re = bind 'i',
	led     = function(from, to, opts) bind('n', { noremap = false })('<leader>' .. from, to, opts) end,
}
