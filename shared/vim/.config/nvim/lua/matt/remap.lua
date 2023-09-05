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

map.led('en', vim.diagnostic.goto_next)
map.led('ep', vim.diagnostic.goto_prev)
map.led('L', function()
	vim.cmd('w')
	local tex_path = vim.api.nvim_buf_get_name(0)
	if string.match(tex_path, '%.tex$') == nil then
		vim.api.nvim_err_writeln('file is not latex')
		return
	end
	vim.cmd('!makelatex.sh %')
	local pdf_path = string.gsub(tex_path, '%.tex$', '.pdf')
	io.popen('swaymsg -- exec evince ' .. pdf_path)
end)
map.n_no_re('gd', vim.lsp.buf.definition)
map.n_no_re('gD', vim.lsp.buf.declaration)
map.n_no_re('gr', vim.lsp.buf.references)
map.n_no_re('gi', vim.lsp.buf.implementation)
map.n_no_re('cA', vim.lsp.buf.code_action)
map.n_no_re('K', vim.lsp.buf.hover)
map.n_no_re('<C-k>', vim.lsp.buf.signature_help)
map.n_no_re('<C-j>', vim.diagnostic.open_float)
map.led('t', '<cmd>TroubleToggle<CR>')
map.n_no_re('<C-n>', vim.diagnostic.goto_prev)
map.n_no_re('<C-p>', vim.diagnostic.goto_next)
map.i_no_re('<C-y>', vim.lsp.buf.code_action)
map.i_no_re('<C-s>', function() vim.cmd('w') end)
map.led('T', function()
	local row = vim.api.nvim_win_get_cursor(0)[1] - 1
	local time = vim.fn.strftime('%A, %e %B %Y')
	vim.api.nvim_buf_set_lines(0, row, row, true, { time, '' })
end)
map.led('gu', '<cmd>GitGutterUndoHunk<CR>')
map.led('gd', '<cmd>GitGutterDiffOrig<CR>')

local tele = require'telescope.builtin'
map.led('ff', tele.find_files)
map.led('fg', tele.live_grep)
map.led('fb', tele.buffers)
map.led('fh', tele.help_tags)
map.led('n', vim.cmd.nohlsearch)

map.led('bp', vim.cmd.BufferPrevious)
map.led('bn', vim.cmd.BufferNext)

map.led('sh', vim.cmd.split)
map.led('sv', vim.cmd.vsplit)

map.led('q', vim.cmd.Bdelete)

map.led('cn', vim.cmd.cnext)
map.led('cp', vim.cmd.cprev)

map.n_no_re('cR', function()
	local new_name = vim.fn.input('New name: ')
	if new_name == '' then
		return
	end
	vim.lsp.buf.rename(new_name)
end)

vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*', callback = function(event)
	local bufnr = event.buffer
	local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	local empty = next(clients) == nil
	if not empty then
		vim.lsp.buf.format { timeout_ms = 100; }
	end
end })

local function set_ext_filetype(exts, filetype)
	vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, { pattern = exts, callback = function() vim.bo.filetype = filetype end })
end
set_ext_filetype({ '*.s', '*.asm' }, 'asm')
