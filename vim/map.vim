"
" Filename:     bind.vim
" Description:  Custom key mappings
"
" Created:      28.03.2020
" Author:       Artyom Danilov
"


" Fast <Esc>.
inoremap jk <esc>

" Toggle folding
nnoremap <space> za


" <leader> [a-zA-Z] {{{

" Write
nnoremap <silent><leader>w :w<CR>

" Write and quit.
nnoremap <silent><leader>q :wq<CR>

" Toggle Goyo
nnoremap <silent><leader>g :Goyo<CR>

" Toggle NERDTree
nnoremap <silent><leader>n :NERDTreeToggle<CR>


" Splits Navigation
nnoremap <silent><leader>h <C-w>h
nnoremap <silent><leader>j <C-w>j
nnoremap <silent><leader>k <C-w>k
nnoremap <silent><leader>l <C-w>l

" Insert new-line
nnoremap <silent><leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent><leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

"}}}


" <leader> [a-zA-Z]{2} {{{

" Edit Vim
nnoremap <silent><leader>ev :split $MYVIMRC<CR>

" Source Vim
nnoremap <silent><leader>sv :source $MYVIMRC<CR>

" DeTab
nnoremap <silent><leader>dt :retab<CR>

" Trim Whitespace
nnoremap <silent><leader>tw :call TrimWhitespace()<CR>

" Visual Comment
nnoremap <silent><leader>vc :call VisualComment()<CR>

" Toggle Color Sheme
nnoremap <silent><leader>cs :call ToggleColorScheme()<CR>

" Toggle Color column
nnoremap <silent><leader>cc :call ToggleColorColumn()<CR>

"}}}


" Arrow keys {{{

inoremap <Left>  <nop>
inoremap <Right> <nop>
inoremap <Up>    <nop>
inoremap <Down>  <nop>

nnoremap <Left>  <nop>
nnoremap <Right> <nop>
nnoremap <Up>    <nop>
nnoremap <Down>  <nop>

vnoremap <Left>  <nop>
vnoremap <Right> <nop>
vnoremap <Up>    <nop>
vnoremap <Down>  <nop>

"}}}
