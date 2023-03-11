scriptencoding utf-8

" File:     javascript.vim
" Created:  31.10.2020
" Author:   Artyom Danilov (@defytheflow)
" Note:     This plugin is loaded in javascriptreact files as well.

setlocal shiftwidth=2
setlocal softtabstop=2

setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal foldnestmax=2
setlocal nofoldenable

setlocal makeprg=node\ %
