
" File:     init.vim
" Created:  30.12.2019
" Author:   Artyom Danilov


" Must be sourced at the top.
source $DOTFILES_HOME/nvim/plugins.vim

" globals + {{{
let g:mapleader = ';'
let g:python3_host_prog = '/usr/bin/python3'
let &path = '/usr/include/,/usr/lib/gcc/x86_64-linux-gnu/8/include'
"}}}

" backup + {{{
set backup
set backupdir=~/.config/nvim/backup
set undofile
set undodir=~/.config/nvim/undodir
set noswapfile
for dir in [&backupdir, &undodir]
    if !isdirectory(dir)
        call mkdir(dir, 'p', 0700)
    endif
endfor
"}}}

" colors + {{{
set termguicolors
set background=dark
try
    colo molokai
catch /^Vim\%((\a\+)\)\=:E185/
    colo koehler
endtry
"}}}

" folding {{{
set foldmethod=marker
" au BufNewFile,BufRead *.py set foldmethod=indent
"}}}

" indentation + {{{
filetype plugin indent on
set expandtab          " Insert spaces instead of tabs.
set softtabstop=4      " Number of spaces inserted for tab.
set shiftwidth=4       " Number of columns to shift with (<< and >>).
set smartindent        " Indent on braces and previous indentation level.
au BufNewFile,BufRead *.html,*.css,*.wiki,
    \    setlocal shiftwidth=2 softtabstop=2  " html, css
au BufNewFile,BufRead *,c,*.py,*.cpp,*.asm,*.sh,*.java
    \    setlocal shiftwidth=4 softtabstop=4  " python, c++, assembly
" }}}

" textwidth + {{{
set nowrap
" set wrap               " Long lines continue to display on the next line.
set textwidth=80       " Maximum width of the text that is being inserted.
set formatoptions+=t   " Wrap text using &textwidth.
set colorcolumn=+0     " Display a color-column to indicate textwidth.
au BufNewFile,BufRead *.c  set textwidth=90
au BufNewFile,BufRead *.py set textwidth=90
"}}}

" searching + {{{
set hlsearch         " Highlight all search matches.
set incsearch
set ignorecase       " Case insensitive search.
set smartcase
"}}}

" statusline + {{{
set ruler              " Show the line and column number of cursor.
set showcmd            " Show last typed command.
set noshowmode         " Do not display mode in status line.
set laststatus=2       " ALways display a status line.
"}}}

" syntax + {{{
syntax enable
au BufNewFile,BufRead *.html set filetype=htmldjango
"}}}

" settings {{{
set clipboard+=unnamedplus         " Use system clipboard.
set history=1000                   " History size.
set number                         " Line numbers.
set mouse=a                        " Enable mouse in all modes.
set splitbelow splitright          " Change splits pos.
set wildmode=longest,list,full     " Autocompletion.
set cursorline
set list listchars=tab:>-,trail:-  " Display tabs and trailing whitespace.
set relativenumber
" Disable highlighting matching parentheses.
au VimEnter * :NoMatchParen
" Disable auto-commenting.
au BufEnter * set fo-=c fo-=r fo-=o
"}}}

" Must be sourced before 'maps.vim'.
source $DOTFILES_HOME/nvim/funcs.vim

" Must be sourced last.
source $DOTFILES_HOME/nvim/maps.vim
