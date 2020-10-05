scriptencoding utf-8

" File:     text.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

setlocal shiftwidth=2
setlocal softtabstop=2

setlocal spell spelllang=en_us

augroup vimrc_spell
  au!
  au ColorScheme * hi SpellBad guifg=#ff0000 ctermfg=Red
augroup END

hi SpellBad guifg=#ff0000 ctermfg=Red
