scriptencoding utf-8

" File:     goyo.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

let g:goyo_width = '90%'

fun! s:goyo_enter()
  set number
  set relativenumber
  set colorcolumn=+0
endfun

augroup vimrc_goyo
  autocmd!
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
augroup END

nnoremap <silent> <leader>z :Goyo<CR>
