
" Filename:     map.vim
" Description:  Custom key mappings

" Created:      28.03.2020
" Author:       Artyom Danilov


" Escape
inoremap jk <esc>

" Fold
nnoremap <space> za
" Toggle search higlighting
noremap <leader>h :set hlsearch! hlsearch?<CR>

nnoremap <leader>e :SyntasticCheck<CR>

" Insert new-line + {{{
nnoremap <silent><leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent><leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>
"}}}

" nerd-tree + {{{
" nnoremap <silent><leader>n :NERDTreeToggle<CR>
nnoremap <silent><leader>t :NERDTreeTabsToggle<CR>
"}}}

" goyo + {{{
nnoremap <silent><leader>g :Goyo<CR>
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

" Disable default tab navifation
nnoremap gt <nop>
nnoremap gT <nop>
"}}}

" Remove[Tab|Whitespace] + {{{
nnoremap <silent><leader>rt :retab<CR>
nnoremap <silent><leader>rw :call TrimWhitespace()<CR>
"}}}

" [Edit|Source]vim + {{{
nnoremap <silent><leader>ev :split $MYVIMRC<CR>
nnoremap <silent><leader>sv :source $MYVIMRC<CR>
"}}}

" Color[Scheme|Column] + {{{
nnoremap <silent><leader>cs :call ToggleColorScheme()<CR>
nnoremap <silent><leader>cc :call ToggleColorColumn()<CR>
" }}}

" Splits + {{{
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

" Visual Comment
nnoremap <silent><leader>vc :call VisualComment()<CR>
