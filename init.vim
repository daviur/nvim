"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|

let mapleader =" "

call plug#begin('~/.config/nvim/plugged')
    Plug 'valloric/youcompleteme'           " Code completion engine
    Plug 'scrooloose/nerdtree'              " File navigator
    Plug 'Xuyuanp/nerdtree-git-plugin'      " Git support for NERDTree
    Plug 'scrooloose/syntastic'             " Syntax checking hacks
    Plug 'junegunn/goyo.vim'                " Makes text more readable
    Plug 'PotatoesMaster/i3-vim-syntax'     " Vim syntax highlighting for i3
    Plug 'tpope/vim-fugitive'               " Git wrapper
    Plug 'airblade/vim-gitgutter'           " Show git diff in the gutter
    Plug 'LukeSmithxyz/vimling'             " Enabling deadkeys e.g. 'a
    Plug 'vimwiki/vimwiki'
    Plug 'vim-airline/vim-airline'          " A light status/tabline
    Plug 'vim-airline/vim-airline-themes'   " Themes for vim-airline
    Plug 'tpope/vim-commentary'             " Use gcc or gc to comment
    Plug 'tpope/vim-surround'               " Quoting/parenthesizing made simple
    Plug 'christoomey/vim-tmux-navigator'   " Seamless navigation between tmux panes and vim splits
    Plug 'skywind3000/asyncrun.vim'         " Enable running shell commands in background and get output in real time
    Plug 'altercation/vim-colors-solarized' " Solarized colorscheme
    Plug 'octol/vim-cpp-enhanced-highlight' " C++ enhanced highlighting
    Plug 'craigemery/vim-autotag'           " Manage CTAGS
    Plug 'junegunn/fzf'                     " Command-line fuzzy finder
    Plug 'junegunn/fzf.vim'
    Plug 'scrooloose/nerdcommenter'         " Comment functions
    " Plug 'kana/vim-textobj-entire'          " Add ae/ie motions to interact with entire buffer
call plug#end()

set bg=light
set mouse=a
set nohlsearch
set clipboard=unnamedplus

" Some basics:
    set nocompatible
    set nrformats-=octal    " Treat all numbers as decimals
    filetype plugin on
    syntax on
    set encoding=utf-8
    set number relativenumber
    set background=dark
    set expandtab           " Tabs expanded to spaces
    set tabstop=4           " Spaces per Tab
    set shiftwidth=4        " Spaces per Shift
    colorscheme solarized

" Enable autocompletion:
    set wildmode=longest,list,full

" Disables automatic commenting on newline:
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo
    map <leader>g :Goyo \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
    map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
    set splitbelow splitright

" FZF
    " Hide statusline of terminal buffer
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
        \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

    " Set prefix for all commands
    let g:fzf_command_prefix = 'Fzf'

    " Mapping selecting mappings
    nmap <leader><tab> <plug>(fzf-maps-n)
    xmap <leader><tab> <plug>(fzf-maps-x)
    omap <leader><tab> <plug>(fzf-maps-o)

    " Insert mode completion
    imap <c-x><c-k> <plug>(fzf-complete-word)
    imap <c-x><c-f> <plug>(fzf-complete-path)
    imap <c-x><c-j> <plug>(fzf-complete-file-ag)
    imap <c-x><c-l> <plug>(fzf-complete-line)

    command! -bang -nargs=? -complete=dir FzfFiles
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

    " Advanced customization using autoload functions
    inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
    nnoremap <expr> <leader>f (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FzfFiles\<CR>"
    nnoremap <expr> <leader>F (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FzfFiles!\<CR>"
    nnoremap <leader>b :FzfBuffers<CR>
    nnoremap <leader>t :FzfTags<CR>

    " This is the default extra key bindings
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

    " Default fzf layout
    " - down / up / left / right
    " let g:fzf_layout = { 'down': '~40%' }

    " In Neovim, you can set up fzf window using a Vim command
    " let g:fzf_layout = { 'window': 'enew' }
    " let g:fzf_layout = { 'window': '-tabnew' }
    " let g:fzf_layout = { 'window': '10split' }

    " Customize fzf colors to match your color scheme
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

    " Enable per-command history.
    " CTRL-N and CTRL-P will be automatically bound to next-history and
    " previous-history instead of down and up. If you don't like the change,
    " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
    let g:fzf_history_dir = '~/.local/share/fzf-history'

    " [Buffers] Jump to the existing window if possible
    " let g:fzf_buffers_jump = 1

    " [[B]Commits] Customize the options used by 'git log':
    " let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

    " [Tags] Command to generate tags file
    " let g:fzf_tags_command = 'ctags -R'

    " [Commands] --expect expression for directly executing the command
    " let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Nerd tree
    map <C-n> :NERDTreeToggle<CR>
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    let NERDTreeIgnore = ['\.pyc', '\.o', '\.lo', '\.so', '\.ko']

" Check file in shellcheck:
    map <leader>s :!clear && shellcheck %<CR>

" Replace all is aliased to S.
    nnoremap S :%s//g<Left><Left>

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

" C++ highlighting
    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight = 1
    let g:cpp_experimental_simple_template_highlight = 1
    " let g:cpp_experimental_template_highlight = 1
    let g:cpp_concepts_highlight = 1
    " let g:cpp_no_function_highlight = 1

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

