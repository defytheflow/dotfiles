
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

" air-line {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
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

" close-tag {{{
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

" delimit-mate {{{
Plug 'Raimondi/delimitMate'
let delimitMate_matchpairs = '(:),[:],{:}'
"}}}

" indent-line {{{
Plug 'Yggdroot/indentLine'
let g:indentLine_char =  '¦'
let g:indentLine_leadingSpaceChar='·'
let g:indentLine_leadingSpaceEnabled='1'
"}}}

" vim-ccls {{{
Plug 'm-pilia/vim-ccls'
let g:ccls_close_on_jump = v:true
"}}}

" vim-gitgutter {{{
Plug 'airblade/vim-gitgutter'
set foldtext=gitgutter#fold#foldtext()
"}}}

" vim-snippets {{{
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

" misc {{{
Plug 'junegunn/goyo.vim'
Plug 'unblevable/quick-scope'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'sheerun/vim-polyglot'
Plug 'miyakogi/seiya.vim'
Plug 'majutsushi/tagbar'
Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}
Plug 'chrisbra/Colorizer'
"}}}

" colors {{{
Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
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
syntax enable
set background=dark
try | colo codedark | catch /^Vim\%((\a\+)\)\=:E185/ |colo koehler | endtry
let g:airline_theme='codedark'
highlight GitGutterAdd    guifg=#00ff00 ctermfg=Green
highlight GitGutterChange guifg=#ffff00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff0000 ctermfg=Red
"}}}

" command-line {{{
set history=1000
set wildmenu " autocompletion.
set wildmode=longest,list,full
"}}}

" indent {{{
filetype plugin indent on
set expandtab          " convert tabs to spaces.
set softtabstop=4      " number of spaces inserted per tab.
set shiftwidth=4       " number of columns to shift with << and >>.
set smartindent        " indent on braces and previous indentation level.
" }}}

" lang {{{
set encoding=utf-8
set langmenu=en_US
let $LANG = 'en_US'
"}}}

" text-width {{{
set nowrap
set textwidth=90
set formatoptions+=t   " wrap text using &textwidth.
set colorcolumn=+0     " display a color-column using &textwidth.
"}}}

" scroll-off {{{
set scrolloff=10
set sidescrolloff=10
"}}}

" search {{{
set hlsearch
set incsearch
set smartcase
"}}}

" status-line {{{
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

" misc {{{
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

" tagbar {{{
nnoremap <silent> <leader>t :TagbarToggle<CR>
"}}}

" shift {{{
vnoremap < <gv
vnoremap > >gv
"}}}

" vim {{{
nnoremap <silent> <leader>ev :split  $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>
"}}}

" misc {{{
nnoremap <silent> <C-l> :nohlsearch<CR>
nnoremap <silent> <C-s> :write<CR>
nnoremap S :%s//g<Left><Left>
nnoremap Y y$
tnoremap <Esc> <C-\><C-n>
"}}}

"}}}

" autocmds {{{

" gui {{{
augroup vimrc_gui
  autocmd!
  autocmd GUIEnter * set vb t_vb=
augroup END
"}}}

" indent {{{
augroup vimrc_indent
  autocmd!
  autocmd FileType sh,vim setlocal shiftwidth=2 softtabstop=2
  autocmd FileType css,html,json setlocal shiftwidth=2 softtabstop=2
augroup END
"}}}

" white-space {{{
augroup vimrc_whitespace
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufWritePre * %s/\n\+\%$//e
augroup END
"}}}

" misc {{{
augroup vimrc_misc
  autocmd!
  " Install pluggins.
  autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | q | endif
  " Jump to the last position when reopening a file.
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  autocmd FileType * set formatoptions-=cro
  autocmd VimEnter * :NoMatchParen
augroup END
"}}}

"}}}
