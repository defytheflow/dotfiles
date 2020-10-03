scriptencoding utf-8

" File:     typescript.vim
" Created:  30.09.2020
" Author:   Artyom Danilov (@defytheflow)

setlocal shiftwidth=2
setlocal softtabstop=2

nnoremap <leader>r :execute '!tsc ' . expand('%:t') '&& node' expand('%:r') . '.js'<CR>
