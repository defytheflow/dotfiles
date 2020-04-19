
" Filename:     map.vim
" Description:  Custom key mappings

" Created:      28.03.2020
" Author:       Artyom Danilov


" Escape
inoremap jk <esc>

" Fold
nnoremap <space> za

" Toggle search higlighting
nnoremap <leader>h :set hlsearch! hlsearch?<CR>

" Remove tabs
nnoremap <silent><leader>rt :retab<CR>

" Visual Comment
nnoremap <silent><leader>vc :call VisualComment()<CR>

" Plugin Toggles {{{
nnoremap <silent><leader>e :SyntasticCheck<CR>
nnoremap <silent><leader>t :NERDTreeTabsToggle<CR>
nnoremap <silent><leader>g :Goyo<CR>
"}}}

" Insert new-line + {{{
nnoremap <silent><leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent><leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>
"}}}

" Buffer[Previous|Next|Delete] + {{{
nnoremap <silent>bp :bprev<CR>
nnoremap <silent>bn :bnext<CR>
nnoremap <silent>bd :bdelete<CR>
"}}}

" Tab[Previous|Next|Open|Quit] + {{{
nnoremap <silent>tp :tabprev<CR>
nnoremap <silent>tn :tabnext<CR>
nnoremap         to :tabedit<Space>
nnoremap <silent>tq :tabclose<CR>
"}}}

" [Edit|Source]vim + {{{
nnoremap <silent><leader>ev :split $MYVIMRC<CR>
nnoremap <silent><leader>sv :source $MYVIMRC<CR>
"}}}

" ColorScheme, ColumnColumn + {{{
nnoremap <silent><leader>cs :call ColorSchemeSwitch()<CR>
nnoremap <silent><leader>cw :call ColorSchemeSave()<CR>
nnoremap <silent><leader>cc :call ColorColumnToggle()<CR>
" }}}

" Splits + {{{

" Resizing
nnoremap <C-y> <C-w><
nnoremap <C-o> <C-w>>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l

tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
"}}}

" Arrow keys + {{{
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
