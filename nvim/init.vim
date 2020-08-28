scriptencoding utf-8

" File:     init.vim
" Created:  30.12.2019
" Author:   Artyom Danilov (@defytheflow)


" vars {{{
let g:mapleader = '\'
let g:python3_host_prog = '/usr/bin/python3'
"}}}

" plugins {{{

" vim-plug {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
"}}}

call plug#begin($HOME . '/.config/nvim/plugged/')

" airline {{{
Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='luna'
"}}}

" ale {{{
Plug 'dense-analysis/ale'
let g:ale_linters = {
\  'c': ['ccls', 'clang'],
\  'python': ['pyls', 'flake8'],
\  'sh': ['shellcheck'],
\  'vim': ['vint'],
\}
let g:ale_fixers = {
\ 'c': ['clang-format'],
\ 'html': ['prettier'],
\ 'javascript': ['prettier'],
\ 'python': ['isort', 'yapf'],
\ 'sh': ['shfmt'],
\}
let g:ale_fix_on_save = 1
"}}}

" camel-case-motion {{{
Plug 'bkad/CamelCaseMotion'
let g:camelcasemotion_key = '<leader>'
"}}}

" closetag {{{
Plug 'alvan/vim-closetag'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx,*js'
let g:closetag_filetypes = 'html,xhtml,phtml,jsx,tsx'
"}}}

" ctrlp {{{
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn|venv)$',
\ 'file': '\v\.(exe|so|dll)$',
\ 'link': 'some_bad_symbolic_links',
\ }
"}}}

" deoplete {{{
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
"}}}

" indentline {{{
Plug 'Yggdroot/indentLine'
let g:indentLine_char =  '¦'
let g:indentLine_leadingSpaceChar='·'
let g:indentLine_leadingSpaceEnabled='1'
"}}}

" snippets {{{
Plug 'SirVer/ultisnips' " engine
Plug 'honza/vim-snippets' " snippets
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsSnippetDirectories=['UltiSnips', '_snippets']
"}}}

" text-object {{{
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'michaeljsmith/vim-indent-object'
"}}}

" tpope {{{
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
"}}}

" miscellaneous {{{
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/goyo.vim'
Plug 'unblevable/quick-scope'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'sheerun/vim-polyglot'
Plug 'miyakogi/seiya.vim'
Plug 'majutsushi/tagbar'
Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}
Plug 'Raimondi/delimitMate'
Plug 'chrisbra/Colorizer'
"}}}

call plug#end()
"}}}

" settings {{{

" backup {{{
set backup
set backupdir=${HOME}/.local/share/nvim/backup
if !isdirectory(&backupdir) | call mkdir(&backupdir, 'p', 0700) | endif
"}}}

" colors {{{
" set termguicolors
set background=dark
try
  colo codedark
catch /^Vim\%((\a\+)\)\=:E185/
  colo koehler
endtry
"}}}

" commandline {{{
set history=1000
set wildmenu " autocompletion.
set wildmode=longest,list,full
"}}}

" indentation {{{
filetype plugin indent on
set expandtab          " convert tabs to spaces.
set softtabstop=4      " number of spaces inserted per tab.
set shiftwidth=4       " number of columns to shift with << and >>.
set smartindent        " indent on braces and previous indentation level.
" }}}

" language {{{
set langmenu=en_US
let $LANG = 'en_US'
"}}}

" textwidth {{{
set nowrap
set textwidth=90
set formatoptions+=t   " wrap text using &textwidth.
set colorcolumn=+0     " display a color-column to indicate textwidth.
"}}}

" scrolloff {{{
set scrolloff=5
set sidescrolloff=5
"}}}

" search {{{
set hlsearch
set incsearch
set smartcase
"}}}

" statusline {{{
set ruler              " show the line and column number of cursor.
set showcmd            " show last typed command.
set noshowmode         " do not display mode in status line.
set laststatus=2       " always display a status line.
"}}}

" undo {{{
set undofile
set undodir=${HOME}/.local/share/nvim/undo
if !isdirectory(&undodir) | call mkdir(&undodir, 'p', 0700) | endif
"}}}

" miscellaneous {{{
syntax enable
set mouse=a
set cursorline
set noswapfile
set foldmethod=marker
set number relativenumber
set splitbelow splitright
set clipboard+=unnamedplus " use system clipboard.
set list listchars=tab:>-,trail:-
set hidden " hide buffers when they are abandoned.
"}}}

"}}}

" functions {{{
fun! ColorColumnToggle()
  if strlen(&colorcolumn) == 0 | set colorcolumn=+1 | else | set colorcolumn= | endif
endfun

fun! CursorColumnToggle()
  if &cursorcolumn == 1 | set nocursorcolumn | else | set cursorcolumn | endif
endfun

fun! CursorLineToggle()
  if &cursorline == 1 | set nocursorline | else | set cursorline | endif
endfun
"}}}

" mappings {{{

" ale {{{
nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gf :ALEFindReferences<CR>
nmap <silent> ]g :ALEPrevious<CR>
nmap <silent> [g :ALENext<CR>
nmap <silent> K  :ALEHover<CR>
"}}}

" better-whitespace {{{
nnoremap <silent> ]w :NextTrailingWhitespace<CR>
nnoremap <silent> [w :PrevTrailingWhitespace<CR>
"}}}

" buffers {{{
nnoremap <silent> <tab>   :bnext<CR>
nnoremap <silent> <S-tab> :bprev<CR>
"}}}

" functions {{{
nnoremap <silent> <leader>cc :call ColorColumnToggle()<CR>
nnoremap <silent> <leader>ch :ColorHighlight<CR>
nnoremap <silent> <leader>ck :call CursorColumnToggle()<CR>
nnoremap <silent> <leader>cl :call CursorLineToggle()<CR>
"}}}

" plugins {{{
nnoremap <silent> <leader>t :TagbarToggle<CR>
nnoremap <silent> <leader>T :NERDTreeTabsToggle<CR>
"}}}

" shift {{{
vnoremap < <gv
vnoremap > >gv
"}}}

" vim {{{
nnoremap <silent> <leader>ev :split  $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>
"}}}

" miscellaneous {{{
nnoremap <silent> <C-l> :nohlsearch<CR>
nnoremap <silent> <C-s> :write<CR>
nnoremap S :%s//g<Left><Left>
nnoremap Y y$
tnoremap <Esc> <C-\><C-n>
"}}}

"}}}

" autocmds {{{
augroup vimrc_gui
  autocmd!
  autocmd GUIEnter * set vb t_vb=
augroup END

augroup vimrc_indentation
  autocmd!
  autocmd FileType sh,vim setlocal shiftwidth=2 softtabstop=2
  autocmd FileType css,html,json setlocal shiftwidth=2 softtabstop=2
augroup END

augroup vimrc_whitespace
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufWritePre * %s/\n\+\%$//e
augroup END

augroup vimrc_miscellaneous
  autocmd!
  " Install pluggins.
  autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | q | endif
  " Jump to the last position when reopening a file.
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  autocmd FileType * set formatoptions-=cro
  autocmd VimEnter * :NoMatchParen
augroup END
"}}}
