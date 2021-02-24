scriptencoding utf-8

" File:     camelcase.vim
" Created:  29.11.2020
" Author:   Artyom Danilov (@defytheflow)

let g:camelcasemotion_key = '<leader>'

map <silent> w  <Plug>CamelCaseMotion_w
map <silent> b  <Plug>CamelCaseMotion_b
map <silent> e  <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge

sunmap w
sunmap b
sunmap e
sunmap ge
