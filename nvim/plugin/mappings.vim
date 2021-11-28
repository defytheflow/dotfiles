scriptencoding utf-8

" File:     mappings.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

" Buffers.
com! BuffNext :bn
com! BuffPrev :bp
com! BuffDel  :bd!

nnoremap <silent> <tab>         :BuffNext<CR>
" nnoremap <silent> <leader><tab> :BuffPrev<CR>
nnoremap <silent> <leader>d     :BuffDel<CR>

" vimrc.
command! Rld :source $MYVIMRC
nnoremap <silent> <leader>ve :edit   $MYVIMRC<CR>
nnoremap <silent> <leader>vs :split  $MYVIMRC<CR>
nnoremap <silent> <leader>vv :vsplit $MYVIMRC<CR>

" Search.
" Use normal regular expression.
nnoremap / /\v
vnoremap / /\v

" Move to the next search result and center the screen.
nnoremap n nzz
nnoremap N Nzz

" Search for word under cursor without jumping to next occurence.
nnoremap # #N
nnoremap * *N

" Remove highlight.
nnoremap <silent> <CR> :nohlsearch<CR>
nnoremap <silent> <C-l> :nohlsearch<CR>

" Movement.
nnoremap j gj
nnoremap k gk

" Visual.
vnoremap < <gv
vnoremap > >gv

" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

" Misc.
" nnoremap Y y$
nnoremap Q <nop>
tnoremap <Esc> <C-\><C-n>

inoremap <silent> <C-c> <nop>
nnoremap <silent> <C-s> :w<CR>

nnoremap <leader><leader> <C-^>
nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
