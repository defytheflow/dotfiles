
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

" ale {{{
Plug 'dense-analysis/ale'
let g:ale_linters = {
\  'c': ['ccls', 'clang'],
\  'python': ['pyls', 'flake8'],
\  'sh': ['language_server', 'shellcheck'],
\  'vim': ['vint'],
\}
let g:ale_fixers = {
\ 'c': ['clang-format'],
\ 'html': ['prettier'],
\ 'javascript': ['prettier'],
\ 'json': ['prettier'],
\ 'python': ['isort', 'yapf'],
\ 'sh': ['shfmt'],
\}
let g:ale_fix_on_save = 1
let g:ale_sh_shfmt_options = '-p -ci -i 2'
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

" light-line {{{
Plug 'itchyny/lightline.vim'
let g:lightline = {
\  'colorscheme': 'powerline',
\}
"}}}

" vim-ccls {{{
Plug 'm-pilia/vim-ccls'
let g:ccls_close_on_jump = v:true
"}}}

" vim-easy-align {{{
Plug 'junegunn/vim-easy-align'
let g:easy_align_ignore_groups = []
"}}}

" vim-gitgutter {{{
Plug 'airblade/vim-gitgutter'
set foldtext=gitgutter#fold#foldtext()
augroup git_gutter_colors " update colors when colorscheme changes.
  autocmd!
  autocmd ColorScheme * highlight GitGutterAdd    guifg=#00ff00 ctermfg=Green
  autocmd ColorScheme * highlight GitGutterChange guifg=#ffff00 ctermfg=Yellow
  autocmd ColorScheme * highlight GitGutterDelete guifg=#ff0000 ctermfg=Red
augroup END
"}}}

" vim-snippets {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'snippet']
"}}}

" quick-scope {{{
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
"}}}

" misc {{{
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'sheerun/vim-polyglot'
Plug 'miyakogi/seiya.vim'
" Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}
Plug 'chrisbra/Colorizer'
Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'jremmen/vim-ripgrep'
"}}}

call plug#end()
"}}}

" settings {{{

" backup {{{
set noswapfile
set backup
set backupdir=${HOME}/.local/share/nvim/backup
if !isdirectory(&backupdir) | call mkdir(&backupdir, 'p', 0700) | endif
"}}}

" colors {{{
syntax enable
set background=dark
try | colo molokai | catch |colo koehler | endtry
"}}}

" command-line {{{
set history=1000
set wildmenu
set wildmode=longest,list,full
"}}}

" errors {{{
set noerrorbells
set novisualbell
augroup vimrc_error_sound
  autocmd!
  autocmd GUIEnter * set vb t_vb= " disable error sounds.
augroup END
"}}}

" indent {{{
filetype plugin indent on
set expandtab " convert tabs to spaces.
set softtabstop=4 " number of spaces inserted per tab.
set shiftwidth=4 " number of columns to shift with << and >>.
set smartindent " indent on braces and previous indentation level.
set autoindent
augroup vimrc_indent
  autocmd!
  autocmd FileType sh,vim setlocal shiftwidth=2 softtabstop=2
  autocmd FileType css,html,json setlocal shiftwidth=2 softtabstop=2
augroup END
" }}}

" lang {{{
let $LANG = 'en'
set langmenu=en
set encoding=utf-8
"}}}

" text-width {{{
set nowrap
set textwidth=90
set formatoptions+=t " wrap text using &textwidth.
set colorcolumn=+0 " display a colorcolumn using &textwidth.
set scrolloff=10
set sidescrolloff=10
"}}}

" search {{{
set hlsearch
set incsearch
set smartcase
"}}}

" status-line {{{
set ruler " show line and column number of cursor.
set showcmd " show last typed command.
set noshowmode " do not display mode in status line.
set laststatus=2 " always display status line.
"}}}

" undo {{{
set undofile
set undodir=${HOME}/.local/share/nvim/undo
if !isdirectory(&undodir) | call mkdir(&undodir, 'p', 0700) | endif
"}}}

" whitespace {{{
set list listchars=tab:>-,trail:-
augroup vimrc_whitespace
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufWritePre * %s/\n\+\%$//e
augroup END
"}}}

" misc {{{
set iskeyword+=- " treat dash separated words as a word text object.
set mouse=a
set cursorline
set foldmethod=marker
set number relativenumber
set splitbelow splitright
set clipboard+=unnamedplus " use system clipboard.
set autoread
set autowrite
set lazyredraw " don't redraw while executing macros.
set hidden
set timeoutlen=500
augroup vimrc_misc
  autocmd!
  autocmd VimEnter    * call InstallPlugins()
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

" ale {{{
nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gf :ALEFindReferences<CR>
nmap <silent> ]g :ALEPrevious<CR>
nmap <silent> [g :ALENext<CR>
nmap <silent> K  :ALEHover<CR>
"}}}

" vim-easy-align {{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"}}}

" highlight {{{
nnoremap <silent> <leader>ch :ColorHighlight<CR>
nnoremap <silent> <leader>cc :execute 'set cc=' . (&cc == '' ? '+1' : '')<CR>
nnoremap <silent> <leader>ck :set cuc!<CR>
nnoremap <silent> <leader>cl :set cul!<CR>
"}}}

" buffers {{{
nnoremap <silent> <tab>   :bn<CR>
nnoremap <silent> <S-tab> :bp<CR>
"}}}

" shift {{{
vnoremap < <gv
vnoremap > >gv
"}}}

" misc {{{
nnoremap <silent> <C-c> <Esc>
nnoremap <silent> <C-l> :nohl<CR>
nnoremap <silent> <C-s> :w<CR>
nnoremap <leader>s  :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <silent> <leader>ve :sp $MYVIMRC<CR>
nnoremap <silent> <leader>vs :so $MYVIMRC<CR>
nnoremap Y y$
tnoremap <Esc> <C-\><C-n>
"}}}

"}}}
