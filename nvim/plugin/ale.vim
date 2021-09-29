scriptencoding utf-8

" File:     ale.vim
" Created:  30.09.2020
" Author:   Artyom Danilov (@defytheflow)

let g:ale_linters = {
\  'c':          ['ccls', 'clang'],
\  'cpp':        ['ccls', 'clang', 'clang-tidy'],
\  'css':        ['stylelint'],
\  'java':       ['javalsp', 'javac'],
\  'javascript': ['eslint', 'tsserver'],
\  'json':       [''],
\  'ocaml':      ['ocamllsp'],
\  'python':     ['pyls','flake8'],
\  'sh':         ['language_server', 'shellcheck'],
\  'typescript': ['tsserver', 'eslint', ],
\  'vim':        ['vimls', 'vint'],
\}

let g:ale_fixers = {
\ 'c':               ['clang-format'],
\ 'cpp':             ['clang-format'],
\ 'css':             ['stylelint'],
\ 'scss':            ['stylelint'],
\ 'html':            ['prettier'],
\ 'java':            ['uncrustify'],
\ 'javascript':      ['prettier'],
\ 'json':            ['prettier'],
\ 'jsonc':           ['prettier'],
\ 'python':          ['isort', 'yapf'],
\ 'sh':              ['shfmt'],
\ 'typescript':      ['prettier'],
\ 'typescriptreact': ['prettier'],
\}

" \ 'ocaml':           ['ocamlformat'],

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

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'

let g:ale_sign_error = '🗙 '
let g:ale_sign_warning = '🗙 '

let g:ale_java_javalsp_executable = 'java-language-server'

let g:ale_sh_shfmt_options = '-p -ci -i 2'
let g:ale_ocaml_ocamlformat_options = '--enable-outside-detected-project'
" let g:ale_python_mypy_options = '--strict'

" let g:ale_linters_explicit = 1
let g:ale_completion_autoimport = 1

let g:ale_python_pyls_config = {
\  'pyls': {
\    'plugins': {
\      'pycodestyle': {
\        'enabled': v:false,
\      },
\      'pyflakes': {
\        'enabled': v:false,
\      },
\  }
\  }
\}

let g:ale_fix_on_save = 1

let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_delay = 5

fun! AleColorsInit()
  hi ALEVirtualTextError guifg=#ff0000 ctermfg=Red
  hi ALEVirtualTextWarning guifg=#ffff00 ctermfg=Yellow

  hi ALEErrorSign guifg=#ff0000 ctermfg=Red
  hi AleWarningSign guifg=#ffff00 ctermfg=Yellow
endfun

augroup vimrc_ale
  au!
  au ColorScheme * call AleColorsInit()
augroup END

call AleColorsInit()

nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gi :ALEDetail<CR>
nmap <silent> gn :ALERename<CR>
nmap <silent> gs :ALEFindReferences<CR>
nmap <silent> [g :ALEPrevious<CR>
nmap <silent> ]g :ALENext<CR>
nmap <silent> gh :ALEHover<CR>
imap <C-Space> <Plug>(ale_complete)
