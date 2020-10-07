scriptencoding utf-8

" File:     java.vim
" Created:  06.10.2020
" Author:   Artyom Danilov (@defytheflow)

setlocal shiftwidth=4
setlocal softtabstop=4

setlocal makeprg=javac\ %

let java_highlight_functions = 1
let java_highlight_all = 1

highlight link JavaIdentifier NONE
