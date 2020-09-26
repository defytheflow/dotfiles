
" File:     ale.vim
" Created:  26.09.2020
" Author:   Artyom Danilov (@defytheflow)
" Info:     ALE configuration.


" variables.
let g:ale_linters = {
\  'c':      ['ccls', 'clang'],
\  'python': ['pyls', 'flake8'],
\  'sh':     ['language_server', 'shellcheck'],
\  'vim':    ['vimls', 'vint'],
\}

let g:ale_fixers = {
\ 'c':          ['clang-format'],
\ 'html':       ['prettier'],
\ 'javascript': ['prettier'],
\ 'json':       ['prettier'],
\ 'python':     ['isort', 'yapf'],
\ 'sh':         ['shfmt'],
\}

let g:ale_fix_on_save = 1
let g:ale_sh_shfmt_options = '-p -ci -i 2'
let g:ale_set_highlights = 0

" mappings.
nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gs :ALEFindReferences<CR>
nmap <silent> ]g :ALEPrevious<CR>
nmap <silent> [g :ALENext<CR>
nmap <silent> K  :ALEHover<CR>
