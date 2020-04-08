
" Filename:     nvim/init.vim
" Description:  Settings

" Created:      30.12.2019
" Author:       Artyom Danilov


" Pluggins
source $DOTFILES_HOME/nvim/plugin.vim

let g:mapleader = ';'  " Leader

" Indentation {{{
set foldmethod=marker  " Fold on markers.
set expandtab          " Insert spaces instead of tabs.
set softtabstop=4      " Number of spaces inserted for tab.
set shiftwidth=4       " Number of columns to shift with (<< and >>).
set smartindent        " Indent on braces and previous indentation level.
set wrap               " Long lines continue to display on the next line.
set textwidth=80       " Maximum width of the text that is being inserted.
set formatoptions+=t   " Wrap text using &textwidth

" Disable auto-commenting.
au BufEnter * set fo-=c fo-=r fo-=o
" Indentation for different file types.
au BufNewFile,BufRead *.c
    \    setlocal shiftwidth=8 softtabstop=8  " c
au BufNewFile,BufRead *.html,*.css
    \    setlocal shiftwidth=2 softtabstop=2  " html, css
au BufNewFile,BufRead *.py,*.cpp,*.asm,*.sh,
    \    setlocal shiftwidth=4 softtabstop=4  " python, c++, assembly
" }}}

" Highlight {{{
syntax enable        " Switch on syntax highlighting.
set background=dark  " Adjust colors for dark mode
set number           " Show line numbers.
set hlsearch         " Highlight search.

" Colorscheme.
try
    colo molokai
catch /^Vim\%((\a\+)\)\=:E185/
    colo koehler
endtry

" Show these characters instead of tabs and trailing space.
set list listchars=tab:>-,trail:-
" Disable highlighting matching parentheses.
autocmd VimEnter * :NoMatchParen
" Highlight trailing whitespaces.
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"}}}

" Backup {{{
set backup
set backupdir=~/.config/nvim/backup
set noswapfile

if !isdirectory(&backupdir)
    call mkdir(&backupdir, 'p', 0700)
endif
"}}}

set splitbelow splitright  " Splits

" Other {{{

set nocompatible  " Enable all vim features.

set encoding=UTF-8

set mouse=a       " Enable mouse for scrolling and resizing.

set history=1000  " Increase the undo limit.

set noshowmode    " Do not display mode in status line.

set ignorecase    " Case insensitive search

set laststatus=2


" }}}

" Abreviations
iabbr #i #include
iabbr #d #define

" Custom Functions (must be sourced before map.vim).
source $DOTFILES_HOME/nvim/function.vim

" Custom Mappings (must be sourced last).
source $DOTFILES_HOME/nvim/map.vim
