scriptencoding utf-8

" File:     test.vim
" Created:  05.10.2020
" Author:   Artyom Danilov (@defytheflow)

let g:test#strategy = 'neovim'
let g:test#neovim#term_position = 'vert'

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
