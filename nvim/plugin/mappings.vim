scriptencoding utf-8

" File:     mappings.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

" Buffers.
nnoremap <silent> <tab>         :bn<CR>
nnoremap <silent> <leader><tab> :bp<CR>
nnoremap <silent> <leader>d     :bd!<CR>

" Vim.
nnoremap <silent> <leader>ve :edit $MYVIMRC<CR>
nnoremap <silent> <leader>vs :source $MYVIMRC<CR>

" Search.
nnoremap / /\v
vnoremap / /\v

" Movement.
nnoremap j gj
nnoremap k gk

" Visual.
vnoremap < <gv
vnoremap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Misc.
nnoremap Y y$
nnoremap Q <nop>
tnoremap <Esc> <C-\><C-n>

inoremap <silent> <C-c> <Esc>
nnoremap <silent> <C-s> :w<CR>
nnoremap <silent> <C-l> :nohl<CR>

nnoremap <leader><leader> <C-^>
nnoremap <leader>s  :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <leader>q :quit<CR>
