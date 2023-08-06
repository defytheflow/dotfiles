scriptencoding utf-8

" File:     gitgutter.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

" set foldtext=gitgutter#fold#foldtext()
" set signcolumn=yes " makes both git status and line number visible

" if system("git rev-parse --is-inside-work-tree") == "true\n"
"   set signcolumn=yes " makes both git status and line number visible
" endif

" fun! GitGutterColorsInit()
"   hi GitGutterAdd    guifg=#00ff00 ctermfg=Green
"   hi GitGutterChange guifg=#ffff00 ctermfg=Yellow
"   hi GitGutterDelete guifg=#ff0000 ctermfg=Red
" endfun

" augroup vimrc_gitgutter
"   au!
"   au ColorScheme * call GitGutterColorsInit()
" augroup END

" call GitGutterColorsInit()
