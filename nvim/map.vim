
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
nnoremap <silent><leader>l :Limelight!!<CR>
nnoremap <silent><leader>se :SeiyaEnable<CR>
nnoremap <silent><leader>sd :SeiyaDisable<CR>
"}}}

" Insert newline + {{{
nnoremap <silent><leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent><leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>
"}}}

" Buffers + {{{
nnoremap <silent>bp :bprev<CR>
nnoremap <silent>bn :bnext<CR>
nnoremap <silent>bd :bdelete<CR>
"}}}

" Tabs + {{{
nnoremap to :tabedit<Space>
nnoremap <silent>tp :tabprev<CR>
nnoremap <silent>tn :tabnext<CR>
nnoremap <silent>tq :tabclose<CR>
"}}}

" Vim Config + {{{
nnoremap <silent><leader>ev :split $MYVIMRC<CR>
nnoremap <silent><leader>sv :source $MYVIMRC<CR>
"}}}

" Color Toggles + {{{
nnoremap <silent><leader>cs :call ColorSchemeSwitch()<CR>
nnoremap <silent><leader>cw :call ColorSchemeSave()<CR>
nnoremap <silent><leader>cc :call ColorColumnToggle()<CR>
nnoremap <silent><leader>cr :call CursorLineToggle()<CR>
" }}}

" Splits + {{{

" Resizing
nnoremap <C-y> <C-w><
nnoremap <C-o> <C-w>>
nnoremap <C-u> <C-w>-
nnoremap <C-i> <C-w>+

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
