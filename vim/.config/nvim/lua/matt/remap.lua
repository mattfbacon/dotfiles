local map = require 'matt.keymap'

local function exists(path)
	local ok, err, code = os.rename(path, path)
	if not ok then
		if code == 13 then
			return true
		end
	end
	return ok
end

map.led('e', '<cmd>Sex<CR>')
map.led('E', '<cmd>Ex<CR>')
map.led('z', 'ZZ')
map.led('q', 'ZQ')
map.led('L', function()
	vim.cmd('w')
	local tex_path = vim.api.nvim_buf_get_name(0)
	if string.match(tex_path, '%.tex$') == nil then
		vim.api.nvim_err_writeln('file is not latex')
		return
	end
	vim.cmd('!./make.sh %')
	local pdf_path = string.gsub(tex_path, '%.tex$', '.pdf')
	io.popen('evince ' .. pdf_path)
end)
map.n_no_re('gd', vim.lsp.buf.definition)
map.n_no_re('gD', vim.lsp.buf.declaration)
map.n_no_re('gr', vim.lsp.buf.references)
map.n_no_re('gi', vim.lsp.buf.implementation)
map.n_no_re('K', vim.lsp.buf.hover)
map.n_no_re('<C-k>', vim.lsp.buf.signature_help)
map.led('t', '<cmd>Trouble<CR>')
-- map.n_no_re('<C-n>', vim.lsp.diagnostic.goto_prev)
-- map.n_no_re('<C-p>', vim.lsp.diagnostic.goto_next)

vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*', command = 'lua vim.lsp.buf.formatting_sync(nil, 100)' })
