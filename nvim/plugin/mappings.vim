scriptencoding utf-8

" File:     mappings.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

" Buffers.
nnoremap <silent> <leader>d     :bd!<CR>

" vimrc.
command! Rld :source $MYVIMRC
nnoremap <silent> <leader>ve :edit   $MYVIMRC<CR>
nnoremap <silent> <leader>vs :split  $MYVIMRC<CR>
nnoremap <silent> <leader>vv :vsplit $MYVIMRC<CR>

" Search.
" Use normal regular expression.
" nnoremap / /\v
" vnoremap / /\v

" Move to the next search result and center the screen.
nnoremap n nzz
nnoremap N Nzz

" Search for word under cursor without jumping to next occurence.
" nnoremap # #N
" nnoremap * *N

" Remove highlight.
" nnoremap <silent> <CR> :nohlsearch<CR>
" nnoremap <silent> <C-l> :nohlsearch<CR>

" Visual.
vnoremap < <gv
vnoremap > >gv

" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

" Misc.
" nnoremap Q <nop>
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
