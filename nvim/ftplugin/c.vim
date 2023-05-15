scriptencoding utf-8

" File:     c.vim
" Created:  14.05.2023
" Author:   Artyom Danilov (@defytheflow)

setlocal shiftwidth=4
setlocal softtabstop=4

setlocal makeprg=make\ %<

nnoremap <leader>mt :w \| :term make %< && ./%< <CR>
