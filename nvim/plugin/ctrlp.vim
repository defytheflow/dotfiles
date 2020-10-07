scriptencoding utf-8

" File:     ctrlp.vim
" Created:  07.10.2020
" Author:   Artyom Danilov (@defytheflow)

let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = 'htmlcov\|plugged'

nnoremap <silent> gb :CtrlPBuffer<CR>
nnoremap <silent> gl :CtrlPLine<CR>
