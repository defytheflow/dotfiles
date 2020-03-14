
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"

" Author:   Artyom Danilov
" Modified: March 14, 2020

" --------------------------------------------------------------------------- "
"                                Indentation                                  "
" --------------------------------------------------------------------------- "
"                                                                             "
"  Each tab is expanded into spaces, num of spaces depends on the FileType.   "
"  Default is 4.                                                              "
"                                                                             "
" --------------------------------------------------------------------------- "

" In Insert mode inserts spaces instead of <Tab>s.
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

" Maximum width of the text that is being inserted.
set textwidth=80
set formatoptions+=t

augroup indentation

    " For C/C++
    autocmd Filetype    c setlocal shiftwidth=8 softtabstop=8
    autocmd Filetype  cpp setlocal shiftwidth=4 softtabstop=4

    " For Python
    autocmd Filetype   py,sh setlocal shiftwidth=4 softtabstop=4

    " For Bash
    autocmd Filetype   sh setlocal shiftwidth=4 softtabstop=4

    " For Assembly
    autocmd Filetype  asm,s setlocal shiftwidth=4 softtabstop=4

    " For HTML
    autocmd FileType html setlocal shiftwidth=2 softtabstop=2

augroup END

" --------------------------------------------------------------------------- "
"                                Highlighting                                 "
" --------------------------------------------------------------------------- "
"                                                                             "
"  Title, Syntax, Line numbers, Matching brackets, Tabs, Trailing spaces,     "
"  81st column.                                                               "
"                                                                             "
" --------------------------------------------------------------------------- "

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
"set number relativenumber
set number

" When a bracket is inserted, briefly jumps to the matching one.
set showmatch

" A list of characters to show instead of tabs and trailing spaces.
set list listchars=tab:>-,trail:-

" Highlight the 81st column with magenta
set colorcolumn=81
highlight ColorColumn ctermbg=5

" --------------------------------------------------------------------------- "
"                                  Splits                                     "
" --------------------------------------------------------------------------- "

" Overrides vim default splitting settings
set splitbelow splitright

" Shortcuts for split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" --------------------------------------------------------------------------- "
"                                  Back up                                    "
" --------------------------------------------------------------------------- "

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
"                                 Remap Escape                                 "
" ---------------------------------------------------------------------------- "

inoremap jk <esc>

" When enteting vim map Caps Lock to Escape.
au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

" When leaving vim map  Caps Lock back to being itself.
au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'"

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

" spell check
function! ToggleSpellCheck()

    if &spell
        set nospell
    else
        set spell
    endif

endfunction

" ---------------------------------------------------------------------------- "
"                                   Mappings                                   "
" ---------------------------------------------------------------------------- "

let mapleader = ";"

source ~/.vim/syntax/comment.vim

nnoremap <silent> <leader>c  :call comment#CommentUncomment() <CR>
vnoremap <silent> <leader>c  :call comment#CommentUncomment() <CR>
nnoremap <silent> <leader>v  :call comment#VisualComment()    <CR>

nnoremap <silent> <leader>n  :call ToggleNumber()         <CR>
nnoremap <silent> <leader>r  :call ToggleRelativeNumber() <CR>
nnoremap <silent> <leader>sc :call ToggleSpellCheck()     <CR>
nnoremap <silent> <C-c>      :call ToggleColorScheme()    <CR>
nnoremap <silent> <C-s>      :call ToggleSyntax()         <CR>

" Edit .vimrc
nnoremap <leader>ev :"split" $MYVIMRC  <CR>
" Source .vimrc
nnoremap <leader>sv :source $MYVIMRC <CR>

" Quoting
"nnoremap <leader>q" ciw""<Esc>P
"nnoremap <leader>q' ciw''<Esc>P
nnoremap <leader>q" ciw"<C-r>""

" ---------------------------------------------------------------------------- "
"                                Abbreviations                                 "
" ---------------------------------------------------------------------------- "

iabbr #i #include
iabbr #d #define
