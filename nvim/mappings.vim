
" File:     mappings.vim
" Created:  28.03.2020
" Author:   Artyom Danilov


" miscellaneous
nnoremap <space> za
nnoremap S :%s//g<Left><Left>
nnoremap Y y$
inoremap jk <esc>

" buffers
nnoremap <tab>   :bnext<cr>
nnoremap <s-tab> :bprev<cr>

" tabs
nnoremap to :tabedit<Space>
nnoremap <silent>tp :tabprev<CR>
nnoremap <silent>tn :tabnext<CR>
nnoremap <silent>tq :tabclose<CR>

" shift
vnoremap < <gv
vnoremap > >gv

nnoremap <silent><leader>rt :retab<CR>
nnoremap <silent><leader>vc :call VisualComment()<CR>
nnoremap <silent><leader>ev :split $MYVIMRC<CR>
nnoremap <silent><leader>sv :source $MYVIMRC<CR>

" plugin toggles
nnoremap <silent><leader>g :Goyo<CR>
nnoremap <silent><leader>n :NERDTreeTabsToggle<CR>
nnoremap <silent><leader>l :Limelight!!<CR>
nnoremap <silent><leader>t :TlistToggle<CR>
nnoremap <silent><leader>se :SeiyaEnable<CR>
nnoremap <silent><leader>sd :SeiyaDisable<CR>

" custom toggles
nnoremap <silent><leader>h  :call HighlightSearchToggle()<CR>
nnoremap <silent><leader>x  :call AutoCommentToggle()<CR>
nnoremap <silent><leader>cc :call ColorColumnToggle()<CR>
nnoremap <silent><leader>cl :call CursorLineToggle()<CR>
nnoremap <silent><leader>ck :call CursorColumnToggle()<CR>

" splits
nnoremap <S-h> <C-w><
nnoremap <S-j> <C-w>-
nnoremap <S-k> <C-w>+
nnoremap <S-l> <C-w>>

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

" arrows
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
