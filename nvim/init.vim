
" Filename:     init.vim
" Description:  nvim settings

" Created:      30.12.2019
" Author:       Artyom Danilov


source $DOTFILES_HOME/nvim/plugin.vim       " Pluggins

let g:mapleader = ';'                       " Leader
let g:python3_host_prog='/usr/bin/python3'  " Python3 interpreter

" Backup + {{{
set backup
set noswapfile
set backupdir=~/.config/nvim/backup

if !isdirectory(&backupdir)
    call mkdir(&backupdir, 'p', 0700)
endif
"}}}

" Colors + {{{
set background=dark
" Don't remove the <-ColoSave-> tag. It is used by ColorSchemeSave function.
try
    colo molokai  " <-ColoSave->
catch /^Vim\%((\a\+)\)\=:E185/
    colo koehler
endtry
"}}}

" Folding {{{
set foldmethod=marker

" Python
" au BufNewFile,BufRead *.py set foldmethod=indent
"}}}

" Indentation + {{{
set expandtab          " Insert spaces instead of tabs.
set softtabstop=4      " Number of spaces inserted for tab.
set shiftwidth=4       " Number of columns to shift with (<< and >>).
set smartindent        " Indent on braces and previous indentation level.

filetype plugin indent on

" Indentation for different file types.
au BufNewFile,BufRead *.html,*.css
    \    setlocal shiftwidth=2 softtabstop=2  " html, css
au BufNewFile,BufRead *,c,*.py,*.cpp,*.asm,*.sh,*.java
    \    setlocal shiftwidth=4 softtabstop=4  " python, c++, assembly
" }}}

" Text-width + {{{
set wrap               " Long lines continue to display on the next line.
set textwidth=80       " Maximum width of the text that is being inserted.
set formatoptions+=t   " Wrap text using &textwidth.
set colorcolumn=+0     " Display a color-column to indicate textwidth.


" Python
au BufNewFile,BufRead *.py set textwidth=100
"}}}

" Searching + {{{
set hlsearch           " Highlight all search matches.
set ignorecase         " Case insensitive search.
"}}}

" Status-line + {{{
set ruler              " Show the line and column number of cursor.
set showcmd            " Show last typed command.
set noshowmode         " Do not display mode in status line.
set laststatus=2       " ALways display a status line.
"}}}

" Syntax + {{{
syntax enable          " Highlight syntax.

" Highligh django syntax in html files.
au BufNewFile,BufRead *.html set filetype=htmldjango
"}}}

" Settings {{{
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

" Custom Functions (must be sourced before map.vim).
source $DOTFILES_HOME/nvim/function.vim

" Custom Mappings (must be sourced last).
source $DOTFILES_HOME/nvim/map.vim
