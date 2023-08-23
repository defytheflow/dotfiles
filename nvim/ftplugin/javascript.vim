scriptencoding utf-8

" File:     javascript.vim
" Created:  31.10.2020
" Author:   Artyom Danilov (@defytheflow)
" Note:     This plugin is loaded in javascriptreact files as well.

setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal nofoldenable

setlocal makeprg=node\ %
