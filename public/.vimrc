" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"
" Author: Artyom Danilov
" Last Modification: February 21, 2020.

" 1. INDENTATION
"
" - Each tab is expanded into spaces, amount of spaces depends on the FileType.
"   Default is 4.
"

" In Insert mode uses the approptiate number of spaces to insert a <Tab>.
set expandtab

" Number of spaces that a <Tab> counts for while performing editing
" operations.
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
    " Indentation for C/C++ source
    autocmd Filetype    c setlocal shiftwidth=8 softtabstop=8
    autocmd Filetype  cpp setlocal shiftwidth=4 softtabstop=4

    " Indentation for Assembly source
    autocmd Filetype  asm setlocal shiftwidth=4 softtabstop=4
    autocmd Filetype    s setlocal shiftwidth=4 softtabstop=4

    " Indentation for HTML source
    autocmd FileType html setlocal shiftwidth=2 softtabstop=2
augroup END

" 2. HIGHLIGHTING
"
" - Syntax, Line numbers, Matching brackets, Tabs, Trailing spaces,
"   81st column.
"

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
set number relativenumber

" When a bracket is inserted, briefly jumps to the matching one.
set showmatch

" A list of characters to show instead of tabs and trailing spaces.
set list listchars=tab:>-,trail:-

" Highlight the 81st column with magenta
set colorcolumn=81
highlight ColorColumn ctermbg=5

" 3. SPLITS

" Overrides vim default splitting settings
set splitbelow splitright

" Shortcuts for split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" 4. BACKUP

set backup
if !isdirectory($HOME . "/.backup/vim")
    call mkdir($HOME . "/.backup/vim", "p", 0700)
endif
set backupdir=~/.backup/vim

" 5. DISABLING ARROWS

" Remove arrows in Normal Mode
nnoremap <Left>  :echo "Type 'h', moron!" <CR>
nnoremap <Right> :echo "Type 'l', prat!"  <CR>
nnoremap <Up>    :echo "Type 'k', git!"   <CR>
nnoremap <Down>  :echo "Type 'j', fool!"  <CR>

" Remove arrows in Visual Mode
vnoremap <Left>  :echo "Type 'h', moron!" <CR>
vnoremap <Right> :echo "Type 'l', prat!"  <CR>
vnoremap <Up>    :echo "Type 'k', git!"   <CR>
vnoremap <Down>  :echo "Type 'j', fool!"  <CR>

" Remove arrows in Insert Mode
inoremap <Left>  <nop>
inoremap <Right> <nop>
inoremap <Up>    <nop>
inoremap <Down>  <nop>

" 6. OTHER

" To enable all vim features
set nocompatible

" Enable mouse for scrolling and resizing.
set mouse=a

" Increase the undo limit
set history=1000

" 7. FUNCTIONS

let mapleader = ";"

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

" comment out line
function! Comment()
    let ft = &filetype
    if ft == 'php' || ft == 'ruby' || ft == 'sh' || ft == 'make'
        \ || ft == 'python' || ft == 'perl'
        silent! s/^/\#/
    elseif ft == 'javascript' || ft == 'c' || ft == 'cpp' || ft == 'java'
        \ || ft == 'objc' || ft == 'scala' || ft == 'go'
        silent! s:^:\/\/:g
    elseif ft == 'vim'
        silent! s:^:\":g
    endif
endfunction

" uncomment line
function! Uncomment()
    let ft = &filetype
    if ft == 'php' || ft == 'ruby' || ft == 'sh' || ft == 'make'
       \ || ft == 'python' || ft == 'perl'
        silent! s/^\#//
    elseif ft == 'javascript' || ft == 'c' || ft == 'cpp' || ft == 'java'
        \ || ft == 'objc' || ft == 'scala' || ft == 'go'
        silent! s:^\/\/::g
    elseif ft == 'vim'
        silent! s:^\"::g
    endif
endfunction


nnoremap <silent> <C-c>      :call Comment()              <CR>
nnoremap <silent> <C-u>      :call Uncomment()            <CR>

nnoremap <silent> <leader>c  :call ToggleColorScheme()    <CR>
nnoremap <silent> <leader>n  :call ToggleNumber()         <CR>
nnoremap <silent> <leader>r  :call ToggleRelativeNumber() <CR>
nnoremap <silent> <leader>sy :call ToggleSyntax()         <CR>
nnoremap <silent> <leader>sc :call ToggleSpellCheck()     <CR>
" 8. MAPPINGS

" edit .vimrc
nnoremap <leader>ev :split $MYVIMRC  <CR>

" source .vimrc
nnoremap <leader>sv :source $MYVIMRC <CR>

" escape
inoremap jk <esc>

" 9. ABBREVIATIONS

iabbr #i #include
iabbr #d #define
