scriptencoding utf-8

" File:     python.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

setlocal shiftwidth=4
setlocal softtabstop=4

nnoremap <leader>r :execute '!python ' . expand('%:t')<CR>
