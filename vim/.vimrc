
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"

" Author:   Artyom Danilov
" Modified: March 13, 2020

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

" --------------------------------------------------------------------------- "
"                               Disable Arrows                                "
" --------------------------------------------------------------------------- "

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

" --------------------------------------------------------------------------- "
"                                  Other                                      "
" --------------------------------------------------------------------------- "

" To enable all vim features
set nocompatible

" Enable mouse for scrolling and resizing.
set mouse=a

" Increase the undo limit
set history=1000

" --------------------------------------------------------------------------- "
"                           Function Definitions                              "
" --------------------------------------------------------------------------- "

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

" Return the token used for commenting in a programming language.
" For example: # in python or // in c++
function! GetCommentToken(filetype)

    let ft = &filetype

    if ft == 'php' || ft == 'ruby' || ft == 'sh' || ft == 'make'
       \ || ft == 'python' || ft == 'perl'
        return '#'
    elseif ft == 'javascript' || ft == 'c' || ft == 'cpp' || ft == 'java'
        \ || ft == 'objc' || ft == 'scala' || ft == 'go'
        return '//'
    elseif ft == 'vim'
        return '"'
    endif

endfunction

" Comment out line
function! Comment()

    let comment_token = GetCommentToken(&filetype)

    if comment_token == '#'
        silent! s/^/\#/
    elseif comment_token == '//'
        silent! s:^:\/\/:g
    elseif comment_token == '"'
        silent! s:^:\":g
    endif

endfunction

" Uncomment line
function! Uncomment()

    let comment_token = GetCommentToken(&filetype)

    if comment_token == '#'
        silent! s/^\#//
    elseif comment_token == '//'
        silent! s:^\/\/::g
    elseif comment_token == '"'
        silent! s:^\"::g
    endif

endfunction

" Print a Visual Comment
function! VisualComment()

    let comment_token = GetCommentToken(&filetype)
    let comment_string = comment_token . ' %s ' . comment_token
    let comment_char = '-'
    let comment_text = input("Text: ")

    " Get the number of char to add on left
    let len   = (80 - len(comment_text) - len(printf(comment_string, '')))
    let left  = len / 2
    let right = len - left

    " Insert in the buffer
    put=printf(comment_string, repeat(comment_char, 76))
    put=printf(comment_string, repeat(' ', left) . comment_text . repeat(' ',  right))
    put=printf(comment_string, repeat(comment_char, 76))

endfunction

" --------------------------------------------------------------------------- "
"                                  Mappings                                   "
" --------------------------------------------------------------------------- "

let mapleader = ";"

nnoremap <silent> <leader>c  :call Comment()              <CR>
nnoremap <silent> <leader>x  :call Uncomment()            <CR>
nnoremap <silent> <leader>v  :call VisualComment()        <CR>

nnoremap <silent> <leader>n  :call ToggleNumber()         <CR>
nnoremap <silent> <leader>r  :call ToggleRelativeNumber() <CR>
nnoremap <silent> <leader>sc :call ToggleSpellCheck()     <CR>

nnoremap <silent> <C-c>      :call ToggleColorScheme()    <CR>
nnoremap <silent> <C-s>      :call ToggleSyntax()         <CR>

" edit .vimrc
nnoremap <leader>ev :split $MYVIMRC  <CR>

" source .vimrc
nnoremap <leader>sv :source $MYVIMRC <CR>

" escape
inoremap jk <esc>

" quote
nnoremap <leader>q" ciw""<Esc>P
nnoremap <leader>q' ciw''<Esc>P

" --------------------------------------------------------------------------- "
"                                  Abbreviations                              "
" --------------------------------------------------------------------------- "

iabbr #i #include
iabbr #d #define
