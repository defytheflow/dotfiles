scriptencoding utf-8

" File:     projectionist.vim
" Created:  27.01.2021
" Author:   Artyom Danilov (@defytheflow)

let g:projectionist_heuristics = {
\  'package.json&tsconfig.json':
\  {
\     '*.tsx': {
\        'type': 'source',
\        'alternate': '{}.test.tsx',
\        'related': '{}.module.scss',
\     },
\     '*.test.tsx': {
\        'type': 'test',
\        'alternate': '{}.tsx',
\        'related': '{}.module.scss',
\     },
\     '*.module.scss': {
\        'type': 'style',
\        'alternate': '{}.tsx',
\        'related': '{}.test.tsx',
\     },
\  }
\}

nnoremap <silent> <leader>aa :A<CR>
nnoremap <silent> <leader>as :AS<CR>
nnoremap <silent> <leader>av :AV<CR>
