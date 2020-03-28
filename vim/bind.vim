" File:      bind.vim
" Purpose:   define custom vim bindings
" Created:   28.03.2020
" Modified:  28.03.2020
" Author:    Artyom Danilov


" Insert mode
" ------------------------------------------------------------------------------
" Disable arrow keys.
inoremap <Left>  <nop>
inoremap <Right> <nop>
inoremap <Up>    <nop>
inoremap <Down>  <nop>

" Fast <Esc>.
inoremap jk <esc>


" Normal mode
" ------------------------------------------------------------------------------
" Disable arrow keys.
nnoremap <Left>  <nop>
nnoremap <Right> <nop>
nnoremap <Up>    <nop>
nnoremap <Down>  <nop>

" Split navigation.
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Edit .vimrc
nnoremap <leader>ev :split $MYVIMRC  <CR>
" Source .vimrc
nnoremap <leader>sv :source $MYVIMRC <CR>

" Insert a new line.
nnoremap <silent> <leader>o
         \ : <C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O
         \ : <C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" Whitespace.
nnoremap <silent> <leader>r  :retab <CR>
nnoremap <silent> <leader>w  :call TrimWhitespace() <CR>

" Commentary.
nnoremap <silent> <leader>v  :call WriteVisualComment() <CR>

" Toggles.
nnoremap <silent> <C-n> :call ToggleNumber()         <CR>
nnoremap <silent> <C-l> :call ToggleRelativeNumber() <CR>
nnoremap <silent> <C-c> :call ToggleColorScheme()    <CR>
nnoremap <silent> <C-x> :call ToggleColorColumn()    <CR>


" Visual mode
" ------------------------------------------------------------------------------
" Disable arrows
vnoremap <Left>  <nop>
vnoremap <Right> <nop>
vnoremap <Up>    <nop>
vnoremap <Down>  <nop>
