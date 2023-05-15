scriptencoding utf-8

" File:     python.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

setlocal shiftwidth=4
setlocal softtabstop=4

setlocal listchars=lead:·

setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal nofoldenable

setlocal makeprg=python3\ %
