scriptencoding utf-8

" File:     swift.vim
" Created:  28.03.2023
" Author:   Artyom Danilov (@defytheflow)

setlocal shiftwidth=4
setlocal softtabstop=4

setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal nofoldenable

setlocal makeprg=swift\ %

nnoremap <leader>mt :w \| :term swift %<CR>
