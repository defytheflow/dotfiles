
" Filename:     nvim/init.vim
" Description:  Settings

" Created:      30.12.2019
" Author:       Artyom Danilov


" Pluggins
source $DOTFILES_HOME/nvim/plugin.vim

" Leader
let g:mapleader = ';'


" Indentation {{{

" Folding type
set foldmethod=marker

" Insert spaces instead of tabs.
set expandtab

" Number of spaces inserted for tab.
set softtabstop=4

" Does smart autoindenting when starting a new-line. Looks at the current line
" for braces and previous indentation level.
set smartindent

" Number of columns to shift with (<< and >>).
set shiftwidth=4

" Lines longer than the width of the window wrap and displaying continues
" on the next line.
set wrap

" Maximum width of the text that is being inserted.
set textwidth=80
set formatoptions+=t

augroup indentation

    " C
    autocmd BufNewFile,BufRead *.c
        \    setlocal shiftwidth=8 softtabstop=8

    " HTML, CSS
    autocmd BufNewFile,BufRead *.html,*.css
        \    setlocal shiftwidth=2 softtabstop=2

    " Python, C++, Assembly
    autocmd BufNewFile,BufRead *.py,*.cpp,*.asm,*.sh,
        \    setlocal shiftwidth=4 softtabstop=4

augroup END

" }}}


" Highlighting {{{

" Color settings.
set t_Co=256
set background=dark

" Colorscheme.
try
    colo molokai
catch /^Vim\%((\a\+)\)\=:E185/
    colo koehler
endtry

" Switch on syntax highlighting.
syntax enable

" Precede each line with its line number.
set number

" Show these characters instead of tabs and trailing space.
set list listchars=tab:>-,trail:-

" Disable highlighting matching parentheses.
autocmd VimEnter * :NoMatchParen

" Disable autocommenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Highlight trailing whitespaces in red
set hlsearch
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

" }}}


" Backup {{{

set backup
set backupdir=~/.config/nvim/backup
set noswapfile

if !isdirectory(&backupdir)
    call mkdir(&backupdir, 'p', 0700)
endif

" }}}


" Splits
set splitbelow splitright


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
