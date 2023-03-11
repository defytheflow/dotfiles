scriptencoding utf-8

" File:     floaterm.vim
" Created:  02.12.2020
" Author:   Artyom Danilov (@defytheflow)

let g:floaterm_width = 0.8
let g:floaterm_height = 0.8

let g:floaterm_autoinsert = v:true
let g:floaterm_winblend = 0

com! Ranger FloatermNew --height=0.8 --width=0.8 ranger
com! Python FloatermNew python
com! Node   FloatermNew node

" nnoremap <silent> <leader>r :Ranger<CR>
nnoremap <silent> <C-t>     :FloatermToggle<CR>
" nnoremap <silent> <C-q>     :FloatermKill<CR>

" let g:floaterm_keymap_prev   = '<leader>fp'
" let g:floaterm_keymap_next   = '<leader>fn'

tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>
tnoremap <silent> <C-q> <C-\><C-n>:FloatermKill<CR>
