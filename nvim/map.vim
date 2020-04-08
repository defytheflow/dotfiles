
" Filename:     map.vim
" Description:  Custom key mappings

" Created:      28.03.2020
" Author:       Artyom Danilov


" Escape
inoremap jk <esc>

" Folding
nnoremap <space> za

nnoremap mm M

" Buffers {{{

" Buffer previous
nnoremap <silent>bp :bprev<CR>
" Buffer next
nnoremap <silent>bn :bnext<CR>

"}}}

" Tabs {{{

" Tab previous
nnoremap <silent>tp :tabprev<CR>
" Tab next
nnoremap <silent>tn :tabnext<CR>
" Tab open
nnoremap to :tabedit<Space>
" Tab quit
nnoremap <silent>tq :tabclose<CR>
" Disable default tab navifation
nnoremap gt <nop>
nnoremap gT <nop>

"}}}

" <leader> [a-zA-Z] {{{

" Toggle Goyo
nnoremap <silent><leader>g :Goyo<CR>
" Open terminal
nnoremap <silent><leader>t :terminal<CR>
" Toggle NERDTree
nnoremap <silent><leader>n :NERDTreeToggle<CR>
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
nnoremap <silent><leader>rt :retab<CR>
" Trim Whitespace
nnoremap <silent><leader>tw :call TrimWhitespace()<CR>
" Visual Comment
nnoremap <silent><leader>vc :call VisualComment()<CR>
" Toggle Color Sheme
nnoremap <silent><leader>cs :call ToggleColorScheme()<CR>
" Toggle Color column
nnoremap <silent><leader>cc :call ToggleColorColumn()<CR>

"}}}

" Splits {{{
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
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
