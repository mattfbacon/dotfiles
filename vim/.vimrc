set nocompatible

let g:rust_recommended_style=0

set viminfofile=~/.cache/viminfo

" NeoVim stuff
let g:python3_host_prog = $HOME . '/.pyenv/versions/3.9.4/bin/python'
let g:python_host_prog = $HOME . '/.pyenv/versions/2.7.18/bin/python'
let g:node_host_prog = '/usr/local/bin/neovim-node-host'

" True color
if has('termguicolors')
	set termguicolors
endif

function! OldTheme()
" Load theme based on time and $TERM
" in non-xterm terminals, use a really simple theme that uses 16-color
" in xterm terminals, load a dark theme between 9 pm and 6 am, otherwise load a light theme
let matchedstring = matchstr($TERM, '\v^xterm')
if !empty(matchedstring)
	let time = str2nr(strftime('%H'), 10)
	if time > 21 || time < 6
		set background=dark
		packadd! srcery
		colorscheme srcery
	else
		set background=light
		packadd! everforest
		colorscheme everforest
	endif
else
	set background=dark
	packadd! disco
	colorscheme disco
endif
endfunction

" Backups and undo files
if has("vms")
	set nobackup
else
	set backup
	if has("persistent_undo")
		set undofile
	endif
endif

set background=light
packadd! boring
colorscheme boring

packadd! gitgutter

lua << EOF
require('feline').setup({ preset = 'noicon' })
EOF

" Swap and Backup
set backupdir=$HOME/.cache/vimbackup//
set directory=$HOME/.cache/vimswap//

" don't do weird stuff
filetype plugin off

filetype indent on
syntax on

" Various syntax matchers
autocmd Filetype ts setlocal syntax=typescript commentstring=//\ %s
autocmd Filetype toml setlocal syntax=toml commentstring=#\ %s
autocmd Filetype fish setlocal syntax=fish commentstring=#\ %s
autocmd Filetype xdefaults setlocal commentstring=!\ %s

" Highlight trailing whitespace
if !exists('g:vscode')
	autocmd Filetype * EnableWhitespace
endif

" Insert text at the current cursor position
function! InsertText(text)
    let cur_line_num = line('.')
    let cur_col_num = col('.')
    let orig_line = getline('.')
    let modified_line =
        \ strpart(orig_line, 0, cur_col_num - 1)
        \ . a:text
        \ . strpart(orig_line, cur_col_num - 1)
    " Replace the current line with the modified line.
    call setline(cur_line_num, modified_line)
    " Place cursor on the last character of the inserted text.
    call cursor(cur_line_num, cur_col_num + strlen(a:text))
endfunction
" Toggle character at end of line
" https://stackoverflow.com/a/18157585/4945014
function! ToggleEndChar(charToMatch)
    s/\v(.)$/\=submatch(1)==a:charToMatch ? '' : submatch(1).a:charToMatch
endfunction

" Show tabs and non-breaking spaces (works together with vim-whitespace)
set listchars=tab:→\ ,nbsp:
set list!

" Show EOB characters
hi link EndOfBuffer Title

" Preferences
set encoding=utf-8
set wrap
set laststatus=2
set hlsearch
set incsearch
set autoindent
set updatetime=300
set shortmess=flmnrxoOtT
set rnu
set nu
set completeopt-=preview
set completeopt+=longest,menuone,noselect
set shortmess+=c
set belloff+=ctrlg
set timeout timeoutlen=700 ttimeoutlen=50
set tabstop=2
set shiftwidth=2
set noexpandtab
set softtabstop=-1
set cursorline

set modeline
set whichwrap+=<,>,[,]
set spell spelllang=en_us

set mouse=a

" Insert current date and time
nnoremap <silent> <Leader>t :call InsertText(strftime('%A, %e %B %Y'))<CR>
" Toggle semicolon at end of line
nnoremap <silent> ;; :call ToggleEndChar(';')<CR>
" Remove highlighted search
noremap <silent><Leader>n :nohlsearch <CR>
" Ctrl+backspace = Ctrl+W
inoremap <C-H> <C-W>

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
