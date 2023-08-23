scriptencoding utf-8

" File:     cpp.vim
" Created:  07.10.2020
" Author:   Artyom Danilov (@defytheflow)

setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4

setlocal makeprg=make\ %<

setlocal path+=/usr/include,/usr/local/include,/usr/include/c++/*/
