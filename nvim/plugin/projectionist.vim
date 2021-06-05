scriptencoding utf-8

" File:     projectionist.vim
" Created:  27.01.2021
" Author:   Artyom Danilov (@defytheflow)

let g:projectionist_heuristics = {
\  'package.json&tsconfig.json':
\  {
\     '*.tsx': {
\        'type': 'source',
\        'alternate': ['{}.scss', '{}.module.scss', '{}.test.tsx'],
\        'related': ['{}.test.tsx', '{}.stories.tsx'],
\     },
\     '*.test.tsx': {
\        'type': 'test',
\        'alternate': '{}.tsx',
\     },
\     '*.scss': {
\       'type': 'style',
\       'alternate': '{}.tsx',
\     },
\     '*.module.scss': {
\        'type': 'style',
\        'alternate': '{}.tsx',
\     },
\     '*.stories.tsx': {
\       'type': 'story',
\       'alternate': '{}.tsx',
\     },
\  },
\  'Pipfile':
\  {
\     '*.py': {
\        'type': 'source',
\        'alternate': '{dirname}/tests/test_{basename}.py'
\     },
\     'src/apps/**/tests/test_*.py': {
\        'type': 'test',
\        'alternate': 'src/apps/{dirname}/{basename}.py'
\     },
\  }
\}

nnoremap <silent> <leader>aa :A<CR>
nnoremap <silent> <leader>as :AS<CR>
nnoremap <silent> <leader>av :AV<CR>
