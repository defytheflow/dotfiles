scriptencoding utf-8

" File:     ultisnips.vim
" Created:  06.10.2020
" Author:   Artyom Danilov (@defytheflow)

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsSnippetDirectories = ['ultisnips']

nnoremap <silent><leader>ue :UltiSnipsEdit<CR>
