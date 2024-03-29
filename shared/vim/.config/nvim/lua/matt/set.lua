local g = vim.g
local o = vim.opt
local v = vim.api.nvim_set_var
local f = vim.fn
local e = vim.env

o.compatible = false

g.rust_recommended_style = 0
g.python3_host_prog = '/usr/bin/python3'
g.python2_host_prog = '/usr/bin/python2'

g.t_SI = '\\e[6 q'
g.t_EI = '\\e[2 q'

o.termguicolors = f.has('termguicolors') == 1
o.backup = true
o.backupskip = ''
o.undofile = true
o.background = light
o.backupdir = e.HOME .. '/.cache/vimbackup//'
o.directory = e.HOME .. '/.cache/vimswap//'
o.undodir = e.HOME .. '/.cache/vimundo//'

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, { pattern = '/mnt/sivydatni/*', callback = function()
	local o = vim.opt
	o.backupdir = '/mnt/sivydatni/.vim/backup//'
	o.directory = '/mnt/sivydatni/.vim/swap//'
	o.undodir = '/mnt/sivydatni/.vim/undo//'
	o.shadafile = '/mnt/sivydatni/.vim/shadafile'
end })

vim.cmd [[
filetype plugin off
filetype indent on
syntax on
hi link EndOfBuffer Title
set completeopt-=preview
set completeopt+=longest,menuone,noselect
]]

o.listchars = 'tab:├─→,lead:·,extends:»,precedes:«,nbsp:'
o.showbreak = '↳'
o.list = true

o.encoding = 'utf-8'
o.wrap = true
o.laststatus = 2
o.hlsearch = true
o.incsearch = true
o.autoindent = true
o.updatetime = 300
o.shortmess = 'flmnrxoOtTc'
o.nu = true
o.rnu = true
o.belloff = 'all'
o.timeout = true
o.timeoutlen = 700
o.ttimeoutlen = 50
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = false
o.softtabstop = -1
o.modeline = true
o.whichwrap = 'b,s,<,>,[,]'
o.spell = true
o.spelllang = 'en_us'
o.spelloptions = 'camel'
o.mouse = 'a'
o.cursorline = f.has 'termguicolors' == 1 and e.TERM ~= 'linux'

g.mapleader = ' '

o.signcolumn = 'yes'
vim.cmd [[
sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text=󰌶 texthl=DiagnosticSignHint linehl= numhl=
]]

vim.lsp.set_log_level 'warn'
