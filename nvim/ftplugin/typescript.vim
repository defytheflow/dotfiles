scriptencoding utf-8

" File:     typescript.vim
" Created:  03.10.2020
" Author:   Artyom Danilov (@defytheflow)
" Note:     This plugin is loaded in typescriptreact files as well.

setlocal shiftwidth=2
setlocal softtabstop=2

setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal nofoldenable

setlocal makeprg=ts-node\ %
