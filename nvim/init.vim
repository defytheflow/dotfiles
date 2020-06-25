
" File:     init.vim
" Created:  30.12.2019
" Author:   Artyom Danilov


" Globals.
let g:mapleader = ';'
let g:python3_host_prog = '/usr/bin/python3'
let &path = '/usr/include/,/usr/lib/gcc/x86_64-linux-gnu/8/include'

" Must be sourced at the top.
source $DOTFILES_HOME/nvim/plugins.vim

" backup {{{
set noswapfile
set backup
set backupdir=${XDG_DATA_HOME}/nvim/backup
if !isdirectory(&backupdir)
    call mkdir(&backupdir, 'p', 0700)
endif
"}}}

" colors {{{
set termguicolors
set background=dark    " adjust colors.
try
    colo codedark
catch /^Vim\%((\a\+)\)\=:E185/
    colo koehler
endtry
"}}}

" commandline {{{
set history=1000                    " history size.
set wildmode=longest,list,full      " autocompletion.
"}}}

" fold {{{
set foldmethod=marker
"}}}

" indent {{{
filetype plugin indent on
set expandtab          " convert tabs to spaces.
set softtabstop=4      " number of spaces inserted per tab.
set shiftwidth=4       " number of columns to shift with << and >>.
set smartindent        " indent on braces and previous indentation level.
au BufNewFile,BufRead *.html,*.css,*.wiki,*.js,*.ts,*.tsx setlocal shiftwidth=2 softtabstop=2
" }}}

" textwidth {{{
set nowrap
set textwidth=90
set formatoptions+=t   " wrap text using &textwidth.
set colorcolumn=+0     " display a color-column to indicate textwidth.
"}}}

" search {{{
set hlsearch           " highlight search matches.
set incsearch          " highlight while typing search pattern.
set smartcase          " ignore case if search pattern is lowercase.
"}}}

" statusline {{{
set ruler              " show the line and column number of cursor.
set showcmd            " show last typed command.
set noshowmode         " do not display mode in status line.
set laststatus=2       " always display a status line.
"}}}

" syntax {{{
syntax enable
au BufNewFile,BufRead *.html set filetype=htmldjango
"}}}

" miscellaneous {{{
set clipboard+=unnamedplus          " use system clipboard.
set cursorline                      " show cursorline.
set number relativenumber           " show relative line numbers.
set mouse=a                         " enable mouse in all modes.
set splitbelow splitright           " change splits position.
set list listchars=tab:>-,trail:-   " display tabs and trailing whitespace.
au VimEnter * :NoMatchParen         " disable highlighting matching parentheses.
au BufEnter * set fo-=c fo-=r fo-=o " disable auto-commenting.
"}}}

" Must be sourced before 'maps.vim'.
source $DOTFILES_HOME/nvim/funcs.vim

" Must be sourced last.
source $DOTFILES_HOME/nvim/maps.vim
