
" Filename:     map.vim
" Description:  Custom key mappings

" Created:      28.03.2020
" Author:       Artyom Danilov


" Edit file under cursor in horizontal split.
nnoremap <leader>sfg <C-W>f
" Edit file under cursor in vertical split.
nnoremap <leader>vfg <C-W>vgf

" Remove tabs
nnoremap <silent><leader>rt :retab<CR>
" Visual Comment
nnoremap <silent><leader>vc :call VisualComment()<CR>

" Enable and disable auto comment
nnoremap <leader>x :setlocal formatoptions-=cro<CR>
nnoremap <leader>X :setlocal formatoptions=cro<CR>

" Plugin Toggles + {{{
nnoremap <silent><leader>g :Goyo<CR>
nnoremap <silent><leader>n :NERDTreeTabsToggle<CR>
nnoremap <silent><leader>l :Limelight!!<CR>
nnoremap <silent><leader>t :TlistToggle<CR>
nnoremap <silent><leader>se :SeiyaEnable<CR>
nnoremap <silent><leader>sd :SeiyaDisable<CR>
"}}}

" Custom Toggles + {{{
nnoremap <silent><leader>cc :call ColorColumnToggle()<CR>
nnoremap <silent><leader>cl :call CursorLineToggle()<CR>
nnoremap <silent><leader>ck :call CursorColumnToggle()<CR>
nnoremap <silent><leader>h  :call HighlightSearchToggle()<CR>
" }}}

" General + {{{
nnoremap <silent><leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent><leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>
nnoremap S :%s//g<Left><Left>
nnoremap Y y$
inoremap jk <esc>
nnoremap <space> za
"}}}

" Shifting + {{{
vnoremap < <gv
vnoremap > >gv
"}}}

" Buffers + {{{
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprev<CR>
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

" Splits + {{{

" Resize.
nnoremap <S-h> <C-w><
nnoremap <S-j> <C-w>-
nnoremap <S-k> <C-w>+
nnoremap <S-l> <C-w>>

" Move focus.
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
