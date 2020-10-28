scriptencoding utf-8

" File:     deoplete.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({'smart_case': v:true})
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment'])
