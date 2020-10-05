scriptencoding utf-8

" File:     gitgutter.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

set foldtext=gitgutter#fold#foldtext()

let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'

augroup vimrc_gitgutter
  au!
  au ColorScheme * highlight GitGutterAdd    guifg=#00ff00 ctermfg=Green
  au ColorScheme * highlight GitGutterChange guifg=#ffff00 ctermfg=Yellow
  au ColorScheme * highlight GitGutterDelete guifg=#ff0000 ctermfg=Red
augroup END
