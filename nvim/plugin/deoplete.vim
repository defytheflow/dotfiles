scriptencoding utf-8

" File:     deoplete.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

let g:deoplete#enable_at_startup = 1

fun! DeopleteSetup()
  " Disable autocompletion inside comments.
  call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment'])
endfun

augroup vimrc_deoplete
  autocmd!
  autocmd VimEnter * call DeopleteSetup()
augroup END
