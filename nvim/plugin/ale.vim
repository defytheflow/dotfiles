scriptencoding utf-8

" File:     ale.vim
" Created:  30.09.2020
" Author:   Artyom Danilov (@defytheflow)

let g:ale_linters = {
\  'c':          ['ccls', 'clang'],
\  'javascript': ['eslint'],
\  'python':     ['pyls', 'mypy', 'flake8'],
\  'sh':         ['language_server', 'shellcheck'],
\  'typescript': ['tsserver', 'tslint'],
\  'vim':        ['vimls', 'vint'],
\}

let g:ale_fixers = {
\ 'c':               ['clang-format'],
\ 'html':            ['prettier'],
\ 'javascript':      ['prettier'],
\ 'json':            ['prettier'],
\ 'python':          ['isort', 'yapf'],
\ 'sh':              ['shfmt'],
\ 'typescript':      ['prettier'],
\ 'typescriptreact': ['prettier'],
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

let g:ale_sign_error = '🗙 '
let g:ale_sign_warning = '🗙 '

let g:ale_sh_shfmt_options = '-p -ci -i 2'
let g:ale_python_mypy_options = '--disallow-untyped-defs --disallow-untyped-calls'

let g:ale_fix_on_save = 1

let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_delay = 5

fun! AleColorsInit()
  hi ALEVirtualTextError guifg=#ff0000 ctermfg=Red
  hi ALEVirtualTextWarning guifg=#ffff00 ctermfg=Yellow

  hi ALEErrorSign guifg=#ff0000 ctermfg=Red
  hi AleWarningSign guifg=#ffff00 ctermfg=Yellow

  hi ALEErrorLine guifg=#ff0000 ctermfg=Red
endfun

augroup vimrc_ale
  au!
  au ColorScheme * call AleColorsInit()
augroup END

call AleColorsInit()

nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gs :ALEFindReferences<CR>
nmap <silent> ]g :ALEPrevious<CR>
nmap <silent> [g :ALENext<CR>
nmap <silent> K  :ALEHover<CR>
