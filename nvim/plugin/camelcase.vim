scriptencoding utf-8

" File:     camelcase.vim
" Created:  29.11.2020
" Author:   Artyom Danilov (@defytheflow)

map <silent> w  <Plug>CamelCaseMotion_w
map <silent> b  <Plug>CamelCaseMotion_b
map <silent> e  <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge

sunmap w
sunmap b
sunmap e
sunmap ge

omap <silent> <leader>iw <Plug>CamelCaseMotion_iw
xmap <silent> <leader>iw <Plug>CamelCaseMotion_iw
omap <silent> <leader>ib <Plug>CamelCaseMotion_ib
xmap <silent> <leader>ib <Plug>CamelCaseMotion_ib
omap <silent> <leader>ie <Plug>CamelCaseMotion_ie
xmap <silent> <leader>ie <Plug>CamelCaseMotion_ie
