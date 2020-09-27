scriptencoding utf-8

" File:     init.vim
" Created:  30.12.2019
" Author:   Artyom Danilov (@defytheflow)

let g:mapleader = '\'
let g:maplocalleader = '\'

if filereadable('/usr/bin/python3')
  let g:python3_host_prog = '/usr/bin/python3'
endif

" plugins {{{

" vim-plug {{{
let vimplug = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vimplug)
  let url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  silent exec '!curl -fLo ' . vimplug . ' --create-dirs ' . url
endif
"}}}

call plug#begin(expand('~/.config/nvim/plugged'))

" ale {{{
Plug 'dense-analysis/ale'
let g:ale_linters = {
\  'c':          ['ccls', 'clang'],
\  'javascript': ['eslint'],
\  'python':     ['pyls', 'flake8'],
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
let g:ale_fix_on_save = 1
let g:ale_sh_shfmt_options = '-p -ci -i 2'
let g:ale_set_highlights = 0
nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gs :ALEFindReferences<CR>
nmap <silent> ]g :ALEPrevious<CR>
nmap <silent> [g :ALENext<CR>
nmap <silent> K  :ALEHover<CR>
"}}}

" camel-case-motion {{{
Plug 'bkad/CamelCaseMotion'
let g:camelcasemotion_key = '<leader>'
"}}}

" ccls {{{
Plug 'm-pilia/vim-ccls'
let g:ccls_close_on_jump = v:true
"}}}

" chadtree {{{
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
let g:chadtree_settings = {
\  'width': 35,
\  'show_hidden': 'true',
\}
let g:chadtree_ignores = {
\  'name': ['htmlcov', '.git', '.idea','__pycache__', '.mypy_cache', '.pytest_cache']
\}
let g:chadtree_view = {
\  'window_options': [
\    'number',
\    'relativenumber',
\    'nowrap',
\    'signcolumn=no',
\    'cursorline',
\    'winfixwidth'
\  ]
\}
nnoremap <leader>f <cmd>CHADopen<cr>
"}}}

" close-tag {{{
Plug 'alvan/vim-closetag'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx,*js'
let g:closetag_filetypes = 'html,xhtml,phtml,jsx,tsx'
"}}}

" ctrlp {{{
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = 'venv\|git\|__pycache__\|.pytest_cache\|plugged\|node_modules'
"}}}

" deoplete {{{
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
"}}}

" delimit-mate {{{
Plug 'Raimondi/delimitMate'
let delimitMate_matchpairs = '(:),[:],{:}'
"}}}

" easy-align {{{
Plug 'junegunn/vim-easy-align'
let g:easy_align_ignore_groups = []
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"}}}

" gitgutter {{{
Plug 'airblade/vim-gitgutter'
set foldtext=gitgutter#fold#foldtext()
augroup vimrc_gitgutter
  autocmd!
  autocmd ColorScheme * highlight GitGutterAdd    guifg=#00ff00 ctermfg=Green
  autocmd ColorScheme * highlight GitGutterChange guifg=#ffff00 ctermfg=Yellow
  autocmd ColorScheme * highlight GitGutterDelete guifg=#ff0000 ctermfg=Red
augroup END
"}}}

" goyo {{{
Plug 'junegunn/goyo.vim'
let g:goyo_width = '90%'
function! s:goyo_enter()
  set number
  set relativenumber
  set colorcolumn=+0
endfunction
augroup vimrc_goyo
  autocmd!
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
augroup END
nnoremap <silent> <leader>z :Goyo<CR>
"}}}

" highlighted-yank {{{
Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 200
"}}}

" indent-line {{{
Plug 'Yggdroot/indentLine'
let g:indentLine_char =  '¦'
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = '1'
augroup vimrc_indentline
  autocmd!
  autocmd Filetype text let g:indentLine_leadingSpaceEnabled = 0
augroup END
"}}}

" lightline {{{
Plug 'itchyny/lightline.vim'
let g:lightline = {
\  'colorscheme': 'powerline',
\}
"}}}

" python-syntax {{{
Plug 'vim-python/python-syntax'
let g:python_highlight_all = 1
"}}}

" sneak {{{
Plug 'justinmk/vim-sneak'
let g:sneak#label = 1
"}}}

" ultisnips {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'ultisnips']
"}}}

" test {{{
Plug 'vim-test/vim-test'
let g:test#strategy = 'neovim'
let g:test#neovim#term_position = 'vert'
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
"}}}

" quick-scope {{{
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
"}}}

" misc {{{
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'miyakogi/seiya.vim'
Plug 'chrisbra/Colorizer'
Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'jremmen/vim-ripgrep'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
"}}}

call plug#end()
"}}}

" settings {{{

" backup {{{
set backup
set noswapfile
set backupdir=${HOME}/.config/nvim/backup
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p', 0700)
endif
"}}}

" colorscheme {{{
set termguicolors " use guifg/guibg instead of ctermfg/ctermfb in terminal.
set background=dark
try
  colorscheme molokai
catch
  colorscheme koehler
endtry
"}}}

" command-line {{{
set history=1000
set wildmenu
set wildmode=longest,list,full
set wildignorecase
"}}}

" indent {{{
filetype plugin indent on
set expandtab " convert <tab> key-presses to spaces.
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
augroup vimrc_indent
  autocmd!
  autocmd FileType sh,zsh,vim,css,html,json,gitconfig,typescript.tsx setlocal shiftwidth=2 softtabstop=2
augroup END
" }}}

" search {{{
set hlsearch
set incsearch
set ignorecase
set smartcase
augroup vimrc_search
  autocmd!
  autocmd ColorScheme * highlight Search ctermfg=LightGreen ctermbg=DarkGray
augroup END
"}}}

" spell {{{
augroup vimrc_spell
  autocmd!
  autocmd Filetype text setlocal spell
augroup END
"}}}

" splits {{{
set fillchars+=vert:┃
set splitbelow
set splitright
" }}}

" status-line {{{
set ruler
set showcmd
set noshowmode
set laststatus=2 " always display status line.
"}}}

" syntax {{{
syntax enable
set iskeyword+=- " treat dash separated words as a word text object.
augroup vimrc_syntax
  autocmd!
  autocmd BufRead setup.cfg setlocal filetype=toml
augroup END
"}}}

" textwidth {{{
set nowrap
set textwidth=90
set formatoptions+=t " wrap text using &textwidth.
set colorcolumn=+0 " display a colorcolumn using &textwidth.
set scrolloff=10
set sidescrolloff=10
"}}}

" undo {{{
set undofile
set undodir=${HOME}/.config/nvim/undo
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p', 0700)
endif
"}}}

" whitespace {{{
set list " show whitespace.
set listchars=tab:ᐅ-
set listchars+=trail:•
set listchars+=nbsp:⦸
set listchars+=extends:»
set listchars+=precedes:«
augroup vimrc_whitespace
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufWritePre * %s/\n\+\%$//e
augroup END
"}}}

" misc {{{
set mouse=a
set hidden
set number
set relativenumber
set cursorline
set virtualedit=block " allow cursor to move where there is no text in visual block mode.
set foldmethod=marker
set clipboard+=unnamedplus " use system clipboard.
set lazyredraw " don't redraw while executing macros.
set timeoutlen=500
set noerrorbells visualbell t_vb=
augroup vimrc_misc
  autocmd!
  autocmd SourcePost $MYVIMRC call InstallPlugins()
  autocmd BufReadPost * call JumpToLastPos()
  autocmd FileType    * set formatoptions-=cro " disable auto-commenting.
  autocmd VimEnter    * :NoMatchParen
augroup END
"}}}

"}}}

" functions {{{
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
"}}}

" mappings {{{

" buffers.
nnoremap gb :ls<CR>:b<space>
nnoremap <silent> <tab>   :bn<CR>
nnoremap <silent> <S-tab> :bp<CR>

" ctrl.
nnoremap <silent> <C-c> <Esc>
nnoremap <silent> <C-l> :nohl<CR>
nnoremap <silent> <C-s> :w<CR>

" highlight.
nnoremap <silent> <leader>cc :execute 'set cc=' . (&cc == '' ? '+1' : '')<CR>
nnoremap <silent> <leader>ch :ColorHighlight<CR>
nnoremap <silent> <leader>ck :set cuc!<CR>
nnoremap <silent> <leader>cl :set cul!<CR>

" vim.
nnoremap <silent> <leader>ve :sp $MYVIMRC<CR>
nnoremap <silent> <leader>vs :so $MYVIMRC<CR>

" visual.
vnoremap < <gv
vnoremap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" misc.
nnoremap <leader><leader> <C-^>
nnoremap <leader>q :quit<CR>
nnoremap Y y$
nnoremap Q <nop>
nnoremap <leader>s  :%s/\<<C-r><C-w>\>//g<Left><Left>
tnoremap <Esc> <C-\><C-n>

"}}}
