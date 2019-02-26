"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|

let mapleader =" "

call plug#begin('~/.config/nvim/plugged')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'Shougo/deoplete-clangx'
	Plug 'Shougo/neco-vim'
	Plug 'scrooloose/nerdtree'		" File navigator
	Plug 'Xuyuanp/nerdtree-git-plugin'	" Git support for NERDTree
	Plug 'scrooloose/syntastic' 		" Syntax checking hacks
	Plug 'junegunn/goyo.vim'		" Makes text more readable
	Plug 'PotatoesMaster/i3-vim-syntax'	" Vim syntax highlighting for i3
	Plug 'tpope/vim-fugitive' 		" Git wrapper
	" Plug 'jreybert/vimagit' 		" git manipulation
	Plug 'airblade/vim-gitgutter' 		" Show git diff in the gutter
	Plug 'LukeSmithxyz/vimling' 		" Enabling deadkeys e.g. 'a
	Plug 'vimwiki/vimwiki'
	Plug 'vim-airline/vim-airline'		" A light status/tabline
	Plug 'vim-airline/vim-airline-themes'	" Themes for vim-airline
	Plug 'tpope/vim-commentary' 		" Use gcc or gc to comment
	Plug 'tpope/vim-surround' 		" Quoting/parenthesizing made simple
	Plug 'christoomey/vim-tmux-navigator'	" Seamless navigation between tmux panes and vim splits
	Plug 'skywind3000/asyncrun.vim'		" Enable running shell commands in background and get output in real time
	Plug 'altercation/vim-colors-solarized'	" Solarized colorscheme
call plug#end()

set bg=light
set mouse=a
set nohlsearch
set clipboard=unnamedplus

" Some basics:
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
	let g:deoplete#enable_at_startup = 1
	set background=dark
	colorscheme solarized

" Enable autocompletion:
	set wildmode=longest,list,full

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo
	map <leader>f :Goyo \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Nerd tree
	map <C-n> :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	let NERDTreeIgnore = ['\.pyc', '\.o', '\.lo']

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Replace all is aliased to S.
"	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
	vnoremap <C-c> "+y
	map <C-p> "+P

" Enable Goyo by default for mutt writting
	" Goyo's width will be the line limit in mutt.
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost ~/.bmdirs,~/.bmfiles !shortcuts

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %

" Navigating with guides
	inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
	vnoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
	map <Space><Tab> <Esc>/<++><Enter>"_c4l

" Shortcutting saving and quitting
	map <C-s> :w<CR>
	map <C-q> :q!<CR>

" Air-line
	let g:airline_powerline_fonts = 1

	if !exists('g:airline_symbols')
	    let g:airline_symbols = {}
	endif

" Unicode symbols
	let g:airline_left_sep = '»'
	let g:airline_left_sep = '▶'
	let g:airline_right_sep = '«'
	let g:airline_right_sep = '◀'
	let g:airline_symbols.linenr = '␊'
	let g:airline_symbols.linenr = '␤'
	let g:airline_symbols.linenr = '¶'
	let g:airline_symbols.branch = '⎇'
	let g:airline_symbols.paste = 'ρ'
	let g:airline_symbols.paste = 'Þ'
	let g:airline_symbols.paste = '∥'
	let g:airline_symbols.whitespace = 'Ξ'

" Airline symbols
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_symbols.branch = ''
	let g:airline_symbols.readonly = ''
	let g:airline_symbols.linenr = ''

 "____        _                  _
"/ ___| _ __ (_)_ __  _ __   ___| |_ ___
"\___ \| '_ \| | '_ \| '_ \ / _ \ __/ __|
 "___) | | | | | |_) | |_) |  __/ |_\__ \
"|____/|_| |_|_| .__/| .__/ \___|\__|___/
              "|_|   |_|
"MARKDOWN
	autocmd Filetype markdown,rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
	autocmd Filetype markdown,rmd inoremap ,n ---<Enter><Enter>
	autocmd Filetype markdown,rmd inoremap ,b ****<++><Esc>F*hi
	autocmd Filetype markdown,rmd inoremap ,s ~~~~<++><Esc>F~hi
	autocmd Filetype markdown,rmd inoremap ,e **<++><Esc>F*i
	autocmd Filetype markdown,rmd inoremap ,h ====<Space><++><Esc>F=hi
	autocmd Filetype markdown,rmd inoremap ,i ![](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,a [](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,1 #<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,2 ##<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,3 ###<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,l --------<Enter>
	autocmd Filetype rmd inoremap ,r ```{r}<CR>```<CR><CR><esc>2kO
	autocmd Filetype rmd inoremap ,p ```{python}<CR>```<CR><CR><esc>2kO
	autocmd Filetype rmd inoremap ,c ```<cr>```<cr><cr><esc>2kO

