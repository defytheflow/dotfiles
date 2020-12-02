scriptencoding utf-8

" File:     fzf.vim
" Created:  25.11.2020
" Author:   Artyom Danilov (@defytheflow)

map <silent> <expr> <C-p> fugitive#head() != ''
\ ? ':GFiles --cached --others --exclude-standard<CR>'
\ : ':Files<CR>'

nnoremap <silent> gb        :Buffers<CR>
nnoremap <silent> <leader>b :Buffers<CR>
