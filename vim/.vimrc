
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"

" Author:      Artyom Danilov
" Modified:    March 14, 2020

" ---------------------------------------------------------------------------- "
"                                 Indentation                                  "
" ---------------------------------------------------------------------------- "
" Overview:                                                                    "
"                                                                              "
" Each <Tab> is expanded into spaces (default - 4).                            "
" Number of expanded spaces depends on the filetype.                           "
" Text is wrapped at 80 characters.                                            "
"                                                                              "
" ---------------------------------------------------------------------------- "

" In Insert mode inserts spaces instead of <Tab>.
set expandtab

" Number of spaces inserted when <Tab> is pressed.
set softtabstop=4

" Does smart autoindenting when starting a new-line. Looks at the current line
" for braces and previous indentation level.
set smartindent

" Controls how many columns text is indented with the reindent operations
" (<< and >>) and automatic C-style indentation.
set shiftwidth=4

" Lines longer than the width of the window wrap and displaying continues
" on the next line.
set wrap
" Maximum width of the text that is being inserted.  set textwidth=80
set formatoptions+=t

augroup indentation
    " Assembly
    autocmd Filetype asm,s setlocal shiftwidth=4 softtabstop=4
    " Bash
    autocmd Filetype    sh setlocal shiftwidth=4 softtabstop=4
    " C
    autocmd Filetype     c setlocal shiftwidth=8 softtabstop=8
    " C++
    autocmd Filetype   cpp setlocal shiftwidth=4 softtabstop=4
    " HTML
    autocmd FileType  html setlocal shiftwidth=2 softtabstop=2
    " Python
    autocmd Filetype    py setlocal shiftwidth=4 softtabstop=4
augroup END

" ---------------------------------------------------------------------------- "
"                                 Highlighting                                 "
" ---------------------------------------------------------------------------- "
" Overview:                                                                    "
"                                                                              "
" Change terminal title.                                                       "
" Highlight syntax.                                                            "
" Display line numbers.                                                        "
" Highlight matching brackets.                                                 "
" Show trailing spaces and tabs.                                               "
" Highlight 81st column.                                                       "
"                                                                              "
" ---------------------------------------------------------------------------  "

" Sets the terminal title (editing 'file')
set title

" Compatibility with tmux colors
set t_Co=256
set background=dark

" Colorschemes
color koehler
"color murphy
"color zellner

" Switches on syntax highlighting.
syntax enable

" Precedes each line with its line number.
set number

" When a bracket is inserted, briefly jumps to the matching one.
set showmatch

" A list of characters to show instead of tabs and trailing spaces.
set list listchars=tab:>-,trail:-

" Highlight the 81st column with magenta
set colorcolumn=81
highlight ColorColumn ctermbg=5

" ---------------------------------------------------------------------------- "
"                                    Splits                                    "
" ---------------------------------------------------------------------------- "

" Overrides vim default splitting settings
set splitbelow splitright

" Shortcuts for split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" ---------------------------------------------------------------------------- "
"                                   Back up                                    "
" ---------------------------------------------------------------------------- "

set backup

if !isdirectory($HOME . "/.backup/vim")
    call mkdir($HOME . "/.backup/vim", "p", 0700)
endif

set backupdir=~/.backup/vim

" ---------------------------------------------------------------------------- "
"                                    Other                                     "
" ---------------------------------------------------------------------------- "

" To enable all vim features
set nocompatible

" Enable mouse for scrolling and resizing.
set mouse=a

" Increase the undo limit
set history=1000

" ---------------------------------------------------------------------------- "
"                                Disable Arrows                                "
" ---------------------------------------------------------------------------- "

" Normal Mode
nnoremap <Left>  :echo "Type 'h', moron!" <CR>
nnoremap <Right> :echo "Type 'l', prat!"  <CR>
nnoremap <Up>    :echo "Type 'k', git!"   <CR>
nnoremap <Down>  :echo "Type 'j', fool!"  <CR>

" Visual Mode
vnoremap <Left>  :echo "Type 'h', moron!" <CR>
vnoremap <Right> :echo "Type 'l', prat!"  <CR>
vnoremap <Up>    :echo "Type 'k', git!"   <CR>
vnoremap <Down>  :echo "Type 'j', fool!"  <CR>

" Insert Mode
inoremap <Left>  <nop>
inoremap <Right> <nop>
inoremap <Up>    <nop>
inoremap <Down>  <nop>

" ---------------------------------------------------------------------------- "
"                             Function Definitions                             "
" ---------------------------------------------------------------------------- "

" Syntax on or off
function! ToggleSyntax()

    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif

endfunction

" Relative number on or off
function! ToggleRelativeNumber()

    if &relativenumber
        set norelativenumber
    else
        set relativenumber
    endif

endfunction

" Number on or off
function! ToggleNumber()

    if &number || &relativenumber
        set nonumber
        set norelativenumber
    else
        set number
        set relativenumber
    endif

endfunction

" Switch colorschemes
function! ToggleColorScheme()

    if g:colors_name == "koehler"
        color murphy
    elseif g:colors_name == "murphy"
        color zellner
    else
        color koehler
    endif

endfunction

" ---------------------------------------------------------------------------- "
"                                   Sources                                    "
" ---------------------------------------------------------------------------- "

source ~/.vim/comment.vim

" ---------------------------------------------------------------------------- "
"                                    Normal                                    "
" ---------------------------------------------------------------------------- "

let mapleader = ";"

nnoremap <silent> <leader>c  :call comment#ToggleLine() <CR>
nnoremap <silent> <leader>v  :call comment#VisualLine() <CR>

nnoremap <silent> <leader>n  :call ToggleNumber()         <CR>
nnoremap <silent> <leader>r  :call ToggleRelativeNumber() <CR>
nnoremap <silent> <C-c>      :call ToggleColorScheme()    <CR>
nnoremap <silent> <C-s>      :call ToggleSyntax()         <CR>

" ---------------------------------------------------------------------------- "
"                                    Visual                                    "
" ---------------------------------------------------------------------------- "

vnoremap <silent> <leader>c  :call comment#ToggleLine() <CR>

" ---------------------------------------------------------------------------- "
"                                    Normal                                    "
" ---------------------------------------------------------------------------- "

" Edit .vimrc
nnoremap <leader>ev :"split" $MYVIMRC  <CR>

" Source .vimrc
nnoremap <leader>sv :source $MYVIMRC <CR>

" Insert new lines
nnoremap <silent> <leader>o : <C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O : <C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" ---------------------------------------------------------------------------- "
"                                    Insert                                    "
" ---------------------------------------------------------------------------- "

" Escape
inoremap jk <esc>

" ---------------------------------------------------------------------------- "
"                                Abbreviations                                 "
" ---------------------------------------------------------------------------- "

iabbr #i #include
iabbr #d #define
