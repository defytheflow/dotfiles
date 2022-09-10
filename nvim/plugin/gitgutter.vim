scriptencoding utf-8

" File:     gitgutter.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

set foldtext=gitgutter#fold#foldtext()
set signcolumn=yes " makes both git status and line numbers to be visible.

let g:gitgutter_map_keys = 0
" let g:gitgutter_sign_added = '✚'
" let g:gitgutter_sign_modified = '✹'

fun! GitGutterColorsInit()
  hi GitGutterAdd    guifg=#00ff00 ctermfg=Green
  hi GitGutterChange guifg=#ffff00 ctermfg=Yellow
  hi GitGutterDelete guifg=#ff0000 ctermfg=Red
endfun

augroup vimrc_gitgutter
  au!
  au ColorScheme * call GitGutterColorsInit()
augroup END

call GitGutterColorsInit()

nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)
