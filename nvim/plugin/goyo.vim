
" File:     goyo.vim
" Created:  26.09.2020
" Author:   Artyom Danilov (@defytheflow)
" Info:     Goyo configuration.


" variables.
let g:goyo_width = '80%'

" functions.
function! s:goyo_enter()
  set number
  set relativenumber
  set colorcolumn=+0
endfunction

" autocmds.
augroup vimrc_goyo
  autocmd!
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
augroup END

" mappings.
nnoremap <silent> <leader>z :Goyo<CR>
