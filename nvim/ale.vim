scriptencoding utf-8

" File:     ale.vim
" Created:  30.09.2020
" Author:   Artyom Danilov (@defytheflow)

let g:ale_linters = {
\  'c':          ['ccls', 'clang'],
\  'javascript': ['eslint'],
\  'python':     ['pyls', 'flake8', 'mypy'],
\  'sh':         ['language_server', 'shellcheck'],
\  'typescript': ['tsserver', 'tslint'],
\  'vim':        ['vimls', 'vint'],
\}

let g:ale_fixers = {
\ 'c':              ['clang-format'],
\ 'html':           ['prettier'],
\ 'javascript':     ['prettier'],
\ 'json':           ['prettier'],
\ 'python':         ['isort', 'yapf'],
\ 'sh':             ['shfmt'],
\ 'typescript':     ['prettier'],
\ 'typescript.tsx': ['prettier'],
\}

let g:ale_completion_symbols = {
\ 'text': '',
\ 'method': '',
\ 'function': '',
\ 'constructor': '',
\ 'field': '',
\ 'variable': '',
\ 'class': '',
\ 'interface': '',
\ 'module': '',
\ 'property': '',
\ 'unit': 'v',
\ 'value': 'v',
\ 'enum': 't',
\ 'keyword': 'v',
\ 'snippet': 'v',
\ 'color': 'v',
\ 'file': 'v',
\ 'reference': 'v',
\ 'folder': 'v',
\ 'enum_member': 'm',
\ 'constant': 'm',
\ 'struct': 't',
\ 'event': 'v',
\ 'operator': 'f',
\ 'type_parameter': 'p',
\ '<default>': 'v'
\ }

let g:ale_sh_shfmt_options = '-p -ci -i 2'
let g:ale_fix_on_save = 1
let g:ale_echo_cursor = 0
let g:ale_hover_cursor = 0
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_delay = 5

augroup vimrc_ale
  autocmd!
  autocmd ColorScheme * highlight ALEError guifg=#ff0000 ctermfg=Red
  autocmd ColorScheme * highlight link ALEErrorSign ALEError
  autocmd ColorScheme * highlight link ALEErrorLine ALEError

  autocmd ColorScheme * highlight ALEWarning guifg=#ffff00 ctermfg=Yellow
  autocmd ColorScheme * highlight link ALEWarningLine ALEWarning
  autocmd ColorScheme * highlight link ALEWarningSign ALEWarning
augroup END

nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gs :ALEFindReferences<CR>
nmap <silent> ]g :ALEPrevious<CR>
nmap <silent> [g :ALENext<CR>
nmap <silent> K  :ALEHover<CR>
