local lsp_status = require 'lsp-status'
lsp_status.register_progress()
lsp_status.config {
	status_symbol = 'LSP'
}
function _G.StatusLine()
	return '%<%f %h%m%r%=' .. lsp_status.status() .. ' %-14.(%l,%c%V%) %P'
end
vim.cmd [[
set statusline=%!v:lua.StatusLine()
]]

