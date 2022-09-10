scriptencoding utf-8

" File:     init.vim
" Created:  30.12.2019
" Author:   Artyom Danilov (@defytheflow)

let g:mapleader = ' '

if filereadable('/usr/bin/python3')
  let g:python3_host_prog = '/usr/bin/python3'
endif

let g:config_dir = has('nvim') ? stdpath('config') : glob('~/.vim')
let g:cache_dir  = has('nvim') ? stdpath('cache')  : glob('~/.vim')

let plug = config_dir . '/autoload/plug.vim'
if !filereadable(plug)
  let url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  silent exec '!curl -fLo ' . plug . ' --create-dirs ' . url
endif

" plugins {{{
call plug#begin(config_dir . '/plugged')

" coc - lsp, completion, diagnostics, refactoring, snippets {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver'
Plug 'neoclide/coc-highlight'
Plug 'neoclide/coc-snippets'
Plug 'honza/vim-snippets'

" Make <tab> used for trigger completion, completion confirm, snippet expand and jump liek VSCode.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
nmap <silent> gs <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K  :call <SID>show_documentation()<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>cac  <Plug>(coc-codeaction)

" Show all diagnostics.
nnoremap <silent><nowait> <leader>cl  :<C-u>CocList diagnostics<cr>

" Manage extensions.
nnoremap <silent><nowait> <leader>ce  :<C-u>CocList extensions<cr>

" Show commands.
nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>

" Find symbol of current document.
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>

" Search workspace symbols.
nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>

" Do default action for next item.
nnoremap <silent><nowait> <leader>cj  :<C-u>CocNext<cr>

" Do default action for previous item.
nnoremap <silent><nowait> <leader>ck  :<C-u>CocPrev<cr>

" Resume latest coc list.
nnoremap <silent><nowait> <leader>cp  :<C-u>CocListResume<cr>

" Restart.
nnoremap <silent><nowait> <leader>cr  :<C-u>CocRestart<CR>
"}}}

" ale - linting and formatting {{{
Plug 'dense-analysis/ale'
let g:ale_linters = {
\  'c':          ['ccls', 'clang'],
\  'cpp':        ['ccls', 'clang', 'clang-tidy'],
\  'css':        ['stylelint'],
\  'java':       ['javalsp', 'javac'],
\  'javascript': ['eslint', 'tsserver'],
\  'json':       [''],
\  'ocaml':      ['ocamllsp'],
\  'typescript': ['tsserver', 'eslint', ],
\  'python':     ['pyls','flake8'],
\  'sh':         ['language_server', 'shellcheck'],
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

" let g:ale_sign_error = '🗙 '
" let g:ale_sign_warning = '🗙 '

let g:ale_java_javalsp_executable = 'java-language-server'

let g:ale_sh_shfmt_options = '-p -ci -i 2'
let g:ale_ocaml_ocamlformat_options = '--enable-outside-detected-project'
" let g:ale_python_mypy_options = '--strict'

let g:ale_linters_explicit = 1
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

" nmap <silent> gd :ALEGoToDefinition<CR>
" nmap <silent> gi :ALEDetail<CR>
" nmap <silent> gn :ALERename<CR>
" nmap <silent> gs :ALEFindReferences<CR>
" nmap <silent> [g :ALEPrevious<CR>
" nmap <silent> ]g :ALENext<CR>
" nmap <silent> gh :ALEHover<CR>
" imap <C-Space> <Plug>(ale_complete)
"}}}

" deoplete - completion (✗) {{{
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif

" let g:deoplete#enable_at_startup = 0
" call deoplete#custom#option({'smart_case': v:true})
" call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment'])
"}}}

" fzf - fuzzy finder {{{
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
map <silent> <C-p> :Files<CR>
" map <silent> <C-p> :execute system('git rev-parse --is-inside-work-tree') =~ 'true' ? 'GFiles' : 'Files' <CR>
" nnoremap <silent> gb        :Buffers<CR>
" nnoremap <silent> <leader>b :Buffers<CR>
"}}}

" goyo - zen mode {{{
Plug 'junegunn/goyo.vim'
let g:goyo_width = '90%'

fun! s:goyo_enter()
  set number
  set relativenumber
  set colorcolumn=+0
endfun

augroup vimrc_goyo
  autocmd!
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
augroup END

nnoremap <silent> <leader>z :Goyo<CR>
"}}}

" nerdtree - file system explorer {{{
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeBookmarksFile = g:cache_dir . '/NERDTreeBookmarks'
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeMinimalUI  = 1
" let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeWinSize = 30
let g:NERDTreeHijackNetrw = 0

let g:NERDTreeGitStatusIndicatorMapCustom = {
\ 'Modified'  :'✹ ',
\ 'Staged'    :'✚ ',
\ 'Untracked' :'✭ ',
\ 'Renamed'   :'➜ ',
\ 'Unmerged'  :'═ ',
\ 'Deleted'   :'✖ ',
\ 'Dirty'     :'✗ ',
\ 'Ignored'   :'☒ ',
\ 'Clean'     :'✔︎ ',
\ 'Unknown'   :'? ',
\ }

augroup vimrc_nerdtree
  au!
  au BufEnter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
augroup END

nnoremap <silent> <C-n> :NERDTreeToggle<CR>
"}}}

" vim-test - tests runner {{{
Plug 'vim-test/vim-test'
let g:test#strategy = 'floaterm' " neovim
let g:test#neovim#term_position = 'below 40' " [vert, below]
let g:test#javascript#runner = 'jest'
let g:test#javascript#jest#executable = 'npm run test'
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
"}}}

" floaterm - displays a floating terminal {{{
Plug 'voldikss/vim-floaterm'
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:floaterm_autoinsert = v:true
let g:floaterm_winblend = 0
" let g:floaterm_keymap_prev   = '<leader>fp'
" let g:floaterm_keymap_next   = '<leader>fn'

com! Ranger FloatermNew --height=0.8 --width=0.8 ranger
com! Python FloatermNew python
com! Node   FloatermNew node

nnoremap <silent> <leader>r :Ranger<CR>
nnoremap <silent> <C-t>     :FloatermToggle<CR>
" nnoremap <silent> <C-q>     :FloatermKill<CR>

tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>
tnoremap <silent> <C-q> <C-\><C-n>:FloatermKill<CR>
"}}}

" projectionist - switch to alternative files quickly {{{
Plug 'tpope/vim-projectionist'
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
"}}}

" gitgutter - shows git diff in the sign column {{{
Plug 'airblade/vim-gitgutter'
set foldtext=gitgutter#fold#foldtext()

let g:gitgutter_map_keys = 0
" let g:gitgutter_sign_added = '✚'
" let g:gitgutter_sign_modified = '✹'

fun! GitGutterColorsInit()
  hi GitGutterAdd    guifg=#00ff00 ctermfg=Green
  hi GitGutterChange guifg=#ffff00 ctermfg=Yellow
  hi GitGutterDelete guifg=#ff0000 ctermfg=Red
endfun

augroup vimrc_gitgutter
  au!
  au ColorScheme * call GitGutterColorsInit()
augroup END

call GitGutterColorsInit()

nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)
"}}}

" Defines camelCase and snake_keys motions (w, b, e).
Plug 'bkad/CamelCaseMotion'
let g:camelcasemotion_key = '<leader>'

" Automatically inserts the closing tag.
Plug 'alvan/vim-closetag'
let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.tsx'
let g:closetag_filetypes = 'html,xhtml,jsx'
" let g:closetag_close_shortcut = '<leader>>'
let g:closetag_regions =  {
\ 'typescript.tsx': 'jsxRegion,tsxRegion',
\ 'javascript.jsx': 'jsxRegion',
\ }

" Automatically renames closing/opening tags.
Plug 'AndrewRadev/tagalong.vim'

" Aligns text.
Plug 'junegunn/vim-easy-align'
let g:easy_align_ignore_groups = []
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Git plugin.
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>

" Git log browser (depends on vim-fugitive ^^^)
Plug 'junegunn/gv.vim'
nnoremap <leader>gl :GV<CR>

" Highlights yank operations.
Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 200

" Displays vertical lines and dots at each indentation level.
Plug 'Yggdroot/indentLine'
let g:indentLine_char =  '¦'
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = '1'
let g:indentLine_fileTypeExclude = ['text', 'vimwiki']

" Highlights unique characters in every word to easier use f, F, t and T.
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Emmet.
Plug 'mattn/emmet-vim'

" Code Snippets. (coc does that)
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" let g:UltiSnipsExpandTrigger = '<tab>'
" let g:UltiSnipsJumpForwardTrigger = '<c-j>'
" let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
" let g:UltiSnipsEditSplit = 'horizontal'
" let g:UltiSnipsSnippetDirectories = ['ultisnips']
" nnoremap <silent><leader>ue :UltiSnipsEdit<CR>

" Highlights colornames and codes. (coc does that)
" Plug 'chrisbra/Colorizer'
" let g:colorizer_auto_filetype='css,html,text,scss'
" let g:colorizer_use_virtual_text = 1

" Displays available keybindings.
Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <leader> :WhichKey '\'<CR>

Plug 'vimwiki/vimwiki'

Plug 'danro/rename.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'justinmk/vim-sneak'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'miyakogi/seiya.vim'
Plug 'cohama/lexima.vim'

" python.
Plug 'jeetsukumaran/vim-pythonsense', { 'for': 'python' }

Plug 'vim-python/python-syntax', { 'for': 'python' }
let g:python_highlight_all = 1

Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
let g:python_pep8_indent_hang_closing = 0

" javascript.
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" text objects.
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-function'
Plug 'michaeljsmith/vim-indent-object'

" colorschemes.
Plug 'tomasiser/vim-code-dark'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'haishanh/night-owl.vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

" syntaxes.
Plug 'mboughaba/i3config.vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'uiiaoo/java-syntax.vim', { 'for': 'java' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'pantharshit00/vim-prisma'

call plug#end()
"}}}

" settings {{{

" essential
filetype plugin indent on
syntax enable

" path.
set path=${HOME}/.config/nvim/*plugin/

" backup.
set backup
set noswapfile
set backupdir=${HOME}/.local/share/nvim/backup
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p', 0700)
endif

" colorscheme.
set termguicolors " use guifg/guibg instead of ctermfg/ctermfb in terminal.
set background=dark
try
  colorscheme night-owl
  " Good ones:
  " base16-classic-dark
  " base16-gruvbox-dark-hard
catch
  colorscheme koehler
endtry
" hi Normal guibg=none

" command-line.
set cmdheight=2
set history=1000
set wildmenu
set wildmode=longest,list,full
set wildignore+=*/.git/*,*/.venv/*,*/node_modules/*,*cache*,*coverage*
set wildignorecase

" fold.
set foldmethod=marker

" gui.
set guifont=FiraCode:h11

" indent.
set expandtab " convert <tab> key-presses to spaces.
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent

" search.
set nohlsearch
set incsearch
set ignorecase
set smartcase

" splits.
set fillchars+=vert:┃
set splitbelow splitright

" status-line.
set ruler
set showcmd
set noshowmode
set laststatus=2 " always display status line.

" textwidth.
set nowrap
set textwidth=90
set formatoptions+=t " wrap text using &textwidth.
set colorcolumn=+0 " display a colorcolumn using &textwidth.
" set scrolloff=10
set sidescrolloff=10

" undo.
set undofile
set undodir=${HOME}/.local/share/nvim/undo
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p', 0700)
endif

" whitespace.
set list " show whitespace.
set listchars=tab:ᐅ-
set listchars+=trail:•
set listchars+=nbsp:⦸
set listchars+=extends:»
set listchars+=precedes:«

" cursorline.
set cursorline
" hi CursorLine guibg=darkblue ctermbg=darkblue
" augroup vimrc_cursorline
"   au!
"   " au InsertEnter * hi CursorLine guibg=darkblue ctermbg=darkblue
"   " au InsertLeave * hi CursorLine guibg=#202020  ctermbg=18
"   au InsertEnter * hi CursorLine guibg=#202020  ctermbg=18
"   au InsertLeave * hi CursorLine guibg=darkblue ctermbg=darkblue
" augroup END

" miscellaneous.
set exrc
set mouse=a
set hidden
set number relativenumber
set virtualedit=block " allow cursor to move where there is no text in visual block mode.
" set clipboard+=unnamedplus " use system clipboard.
set lazyredraw " don't redraw while executing macros.
set timeoutlen=500
set noerrorbells visualbell t_vb=
"}}}

" mappings {{{
" Buffers.
" com! BuffNext :bn
" com! BuffPrev :bp
" com! BuffDel  :bd!

" nnoremap <silent> <tab>         :bn<CR>
" nnoremap <silent> <leader><tab> :bp<CR>
nnoremap <silent> <leader>d     :bd!<CR>

" vimrc.
command! Rld :source $MYVIMRC
nnoremap <silent> <leader>ve :edit   $MYVIMRC<CR>
nnoremap <silent> <leader>vs :split  $MYVIMRC<CR>
nnoremap <silent> <leader>vv :vsplit $MYVIMRC<CR>

" Search.
" Use normal regular expression.
" nnoremap / /\v
" vnoremap / /\v

" Move to the next search result and center the screen.
nnoremap n nzz
nnoremap N Nzz

" Search for word under cursor without jumping to next occurence.
" nnoremap # #N
" nnoremap * *N

" Remove highlight.
" nnoremap <silent> <CR> :nohlsearch<CR>
" nnoremap <silent> <C-l> :nohlsearch<CR>

" Movement.
" nnoremap j gj
" nnoremap k gk

" Visual.
vnoremap < <gv
vnoremap > >gv

" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

" Misc.
" nnoremap Y y$
" nnoremap Q <nop>
tnoremap <Esc> <C-\><C-n>

" inoremap <silent> <C-c> <nop>
" nnoremap <silent> <C-s> :w<CR>

" nnoremap <leader><leader> <C-^>
" nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
"}}}

" autocommands {{{
augroup vimrc_syntax
  au!
  au BufNewFile,BufRead setup.cfg             setlocal ft=toml
  au BufNewFile,BufRead .prettierrc,.eslintrc setlocal ft=json
  au BufNewFile,BufRead ~/.config/i3/config   setlocal ft=i3config
augroup END

augroup vimrc_whitespace
  au!
  au BufWritePre * %s/\s\+$//e
  au BufWritePre * %s/\n\+\%$//e
augroup END

augroup vimrc_indent
  au!
  au FileType ocaml,lua,*sh,vim,*css,html*,git*,toml,sql,prisma setlocal shiftwidth=2 softtabstop=2
  au FileType vimwiki runtime ftplugin/text.vim
augroup END

fun! InstallPlugins()
  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    PlugInstall --sync | q
  endif
endfun

fun! JumpToLastPos()
  if line("'\"") > 1 && line("'\"") <= line('$')
    exe "normal! g'\""
  endif
endfun

augroup vimrc_misc
  au!
  au BufReadPost * call JumpToLastPos()
  au FileType    * set formatoptions-=cro " disable auto-commenting.
  au VimEnter    * :NoMatchParen
  au SourcePost   $MYVIMRC call InstallPlugins()
augroup END

augroup vimrc_binary
  au!
  au BufReadPre  *.bin let &bin = 1

  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif

  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif

  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END
"}}}

digraph R! 128640 " rocket emoji.
digraph T! 129394 " smilint face with tear emoji.
digraph OO 129417 " owl emoji.