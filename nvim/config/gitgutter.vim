scriptencoding utf-8

" File:     gitgutter.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

set foldtext=gitgutter#fold#foldtext()

let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'

augroup vimrc_gitgutter
  autocmd!
  autocmd ColorScheme * highlight GitGutterAdd    guifg=#00ff00 ctermfg=Green
  autocmd ColorScheme * highlight GitGutterChange guifg=#ffff00 ctermfg=Yellow
  autocmd ColorScheme * highlight GitGutterDelete guifg=#ff0000 ctermfg=Red
augroup END
