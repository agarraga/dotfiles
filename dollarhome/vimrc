""        _                     ""
"" __   _(_)_ __ ___  _ __ ___  ""
"" \ \ / / | '_ ` _ \| '__/ __| ""
""  \ V /| | | | | | | | | (__  ""
"" (_)_/ |_|_| |_| |_|_|  \___| ""

" Big stuff
filetype plugin indent on
set autoread
set noautowrite
set hidden
set nocompatible
set mouse=a
set nobackup
set noswapfile
set nowritebackup
set timeoutlen=640
set encoding=utf-8
set undofile
if !has('nvim')
	set undodir=~/.vim/undodir
elseif has('nvim')
	set undodir=~/.config/nvim/undodir
endif

" Display and metadata
syntax on
set background=dark
set colorcolumn=100
set cursorline
set laststatus=2
set linebreak
set list
set listchars=tab:\ \ ,trail:·
set noshowmode
set nowrap
set number
set relativenumber
set ruler
set scrolloff=8
set showcmd
set showmatch
set spell
set spelllang=en_us,en_gb
set spellcapcheck=
set spellsuggest=fast
set synmaxcol=300
set title
set wildmenu

" Navigation and editing
set backspace=indent,eol,start
set autoindent
set smartindent
set cindent
set foldlevel=99
set completeopt=fuzzy,menu,popup

if !has('nvim')
	set foldmethod=syntax
	setlocal omnifunc=syntaxcomplete#Complete
endif

" Tabs and Spaces
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab

" Searches
set nohlsearch
set incsearch
set ignorecase
set smartcase
set path+=**

augroup toggle_relnum
	autocmd!
	autocmd InsertEnter * :set norelativenumber
	autocmd InsertLeave * :set relativenumber
augroup END

" Pretty
if !has('nvim')
	colorscheme slate
elseif has('nvim')
	colorscheme habamax
endif
hi Normal ctermbg=NONE

nnoremap <SPACE> <Nop>
let mapleader=" "
let maplocalleader="\\"

" MY REMAPS
nnoremap <leader><leader> :let@/=""<CR>

inoremap kj <esc>
vnoremap kj <esc>

nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

nnoremap Y y$

nnoremap { :<c-u>execute "keepjumps norm! " . v:count1 . "{"<cr>
nnoremap } :<c-u>execute "keepjumps norm! " . v:count1 . "}"<cr>

nnoremap J mzJ`z
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz

map q: <nop>
nnoremap Q <nop>
nnoremap ZZ <nop>

nnoremap <localleader>dl diffget LOCAL
nnoremap <localleader>dr diffget REMOTE
nnoremap <localleader>db diffget BASE

nnoremap <leader>ff :find<space>

" Create tags file
command! Maketags !ctags -R .

augroup remember_cursor_on_reopen
	autocmd!
	autocmd BufReadPost * silent! normal! g`"zv
augroup END

augroup yank_restore_cursor
	autocmd!
	autocmd VimEnter,CursorMoved *
		\ let s:cursor = getpos('.')
	autocmd TextYankPost *
		\ if v:event.operator ==? 'y' |
			\ call setpos('.', s:cursor) |
		\ endif
augroup END

augroup highlight_yanked_text
	autocmd!
	autocmd TextYankPost * call FlashYankText()
augroup END

function! FlashYankText()
	if (!exists('g:yank_text_matches'))
		let g:yank_text_matches = []
	endif

	let match_id = matchadd('IncSearch', ".\\%>'\\[\\_.*\\%<']..")
	let win_id = winnr()

	call add(g:yank_text_matches, [win_id, match_id])
	call timer_start(120, 'DeleteTempMatch')
endfunction

function! DeleteTempMatch(timer_id)
	while !empty(g:yank_text_matches)
		let match = remove(g:yank_text_matches, 0)
		let win_id = match[0]
		let match_id = match[1]

		try
			call matchdelete(match_id, win_id)
		endtry
	endwhile
endfunction

" FileType autocmds

augroup filetype_settings
	autocmd!
	autocmd FileType gitcommit
		\ setlocal colorcolumn=72
	autocmd FileType python
		\ setlocal tabstop=4		|
		\ setlocal softtabstop=4	|
		\ setlocal shiftwidth=4		|
		\ setlocal expandtab
	autocmd FileType html,js,css,tex
		\ setlocal tabstop=2		|
		\ setlocal softtabstop=2	|
		\ setlocal shiftwidth=2		|
		\ setlocal expandtab
augroup END

" PLUGINS!

let my_plugins = [
	"\ Editing and navigation
	\'https://github.com/tpope/vim-repeat',
	\'https://github.com/tpope/vim-surround',
	"\ Text Objects
	\'https://github.com/kana/vim-textobj-user',
	\'https://github.com/kana/vim-textobj-indent',
	\'https://github.com/kana/vim-textobj-function',
	\'https://github.com/adolenc/vim-textobj-toplevel',
	\'https://github.com/D4KU/vim-textobj-chainmember',
	\'https://github.com/mattn/vim-textobj-url',
	\'https://github.com/Julian/vim-textobj-variable-segment',
	\'https://github.com/vim-scripts/argtextobj.vim',
	\'https://github.com/itchyny/lightline.vim',
	\]

if !has('nvim')

	" Install vim-plug if not found
	if empty(glob('~/.vim/autoload/plug.vim'))
	  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	endif

	" Run PlugInstall if there are missing plugins
	autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	  \| PlugInstall --sync | source $MYVIMRC
	\| endif

	call plug#begin('~/.vim/plugged')
	Plug 'junegunn/vim-plug'

	for p in my_plugins
		Plug p
	endfor

	Plug 'tpope/vim-commentary'

	" Tidalcycles
	Plug 'tidalcycles/vim-tidal'

	call plug#end()

endif
