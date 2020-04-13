
" Filename:     init.vim
" Description:  nvim settings

" Created:      30.12.2019
" Author:       Artyom Danilov


source $DOTFILES_HOME/nvim/plugin.vim  " Pluggins

let g:mapleader = ';'  " Leader

let g:python3_host_prog='/usr/bin/python3'

" abbreviate + {{{
iabbr #i #include
iabbr #d #define
"}}}

" backup + {{{
set backup
set backupdir=~/.config/nvim/backup
set noswapfile

if !isdirectory(&backupdir)
    call mkdir(&backupdir, 'p', 0700)
endif
"}}}

" color-scheme + {{{
set background=dark  " Adjust colors for dark mode
try
    colo palenight
catch /^Vim\%((\a\+)\)\=:E185/
    colo koehler
endtry
"}}}

" filetype + {{{
filetype on
filetype plugin on
filetype indent on
"}}}

" folding + {{{
set foldmethod=marker  " Fold on markers.
"}}}

" indentation + {{{
set expandtab          " Insert spaces instead of tabs.
set softtabstop=4      " Number of spaces inserted for tab.
set shiftwidth=4       " Number of columns to shift with (<< and >>).
set smartindent        " Indent on braces and previous indentation level.

" Indentation for different file types.
au BufNewFile,BufRead *.c
    \    setlocal shiftwidth=8 softtabstop=8  " c
au BufNewFile,BufRead *.html
    \    setlocal shiftwidth=2 softtabstop=2  " html, css
au BufNewFile,BufRead *.py,*.cpp,*.asm,*.sh,
    \    setlocal shiftwidth=4 softtabstop=4  " python, c++, assembly
" }}}

" mouse + {{{
set mouse=a  " Enable mouse for scrolling and resizing.
"}}}

" text-width + {{{
set wrap               " Long lines continue to display on the next line.
set textwidth=80       " Maximum width of the text that is being inserted.
set formatoptions+=t   " Wrap text using &textwidth
set colorcolumn=+0     " Display a color-column to indicate textwidth
"}}}

" whitespace + {{{
set list listchars=tab:>-,trail:- " Display tabs and trailing whitespace
"}}}

" search + {{{
" set incsearch   " Highlight search.
set hlsearch    " Highlight all search matches.
set ignorecase  " Case insensitive search
"}}}

" status-line + {{{
set ruler         " Show the line and column number of cursor.
set showcmd       " Show last typed command
set noshowmode    " Do not display mode in status line.
set laststatus=2  " ALways display a status line
"}}}

" splits + {{{
set splitbelow splitright  " Splits
"}}}

" syntax + {{{
syntax enable   " Syntax highlighting.
au BufNewFile,BufRead *.html set filetype=htmldjango
"}}}

" other {{{
set encoding=UTF-8
set history=1000  " Increase the undo limit.
set number      " Line numbers.
" Disable highlighting matching parentheses.
au VimEnter * :NoMatchParen
" Disable auto-commenting.
au BufEnter * set fo-=c fo-=r fo-=o
"}}}

" Custom Functions (must be sourced before map.vim).
source $DOTFILES_HOME/nvim/function.vim

" Custom Mappings (must be sourced last).
source $DOTFILES_HOME/nvim/map.vim
