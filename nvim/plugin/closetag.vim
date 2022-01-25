scriptencoding utf-8

" File:     closetag.vim
" Created:  03.01.2021
" Author:   Artyom Danilov (@defytheflow)

let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.tsx'
let g:closetag_filetypes = 'html,xhtml,jsx'
" let g:closetag_close_shortcut = '<leader>>'
let g:closetag_regions =  {
\ 'typescript.tsx': 'jsxRegion,tsxRegion',
\ 'javascript.jsx': 'jsxRegion',
\ }
