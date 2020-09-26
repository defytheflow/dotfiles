
" File:     init.vim
" Created:  30.12.2019
" Author:   Artyom Danilov (@defytheflow)


let g:mapleader = '\'
let g:python3_host_prog = '/usr/bin/python3'

" plugins {{{

" vim-plug {{{
let vimplug = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vimplug)
  let url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  silent exec '!curl -fLo ' . vimplug . ' --create-dirs ' . url
endif
"}}}

call plug#begin(expand('~/.config/nvim/plugged'))

" camel-case-motion {{{
Plug 'bkad/CamelCaseMotion'
let g:camelcasemotion_key = '<leader>'
"}}}

" ccls {{{
Plug 'm-pilia/vim-ccls'
let g:ccls_close_on_jump = v:true
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

" easy-align {{{
Plug 'junegunn/vim-easy-align'
let g:easy_align_ignore_groups = []
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

" light-line {{{
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

" snippets {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'ultisnips']
"}}}

" quick-scope {{{
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
"}}}

" misc {{{
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
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
Plug 'miyakogi/seiya.vim'
Plug 'chrisbra/Colorizer'
Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'jremmen/vim-ripgrep'
Plug 'vim-test/vim-test'
"}}}

" devicons {{{
Plug 'ryanoasis/vim-devicons'
augroup vimrc_devicons
  autocmd!
  autocmd SourcePost $MYVIMRC if exists('g:loaded_webdevicons') | call webdevicons#refresh() | endif
augroup END
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
set background=dark
try | colo molokai | catch |colo koehler | endtry
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
  autocmd FileType sh,zsh,vim,css,html,json,gitconfig setlocal shiftwidth=2 softtabstop=2
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
set ignorecase
set smartcase
augroup vimrc_search
  autocmd!
  autocmd ColorScheme * highlight Search ctermfg=LightGreen ctermbg=DarkGray
augroup END
"}}}

" status-line {{{
set ruler
set showcmd
set noshowmode
set laststatus=2 " always display status line.
"}}}

" spell {{{
augroup vimrc_spell
  autocmd!
  autocmd Filetype text setlocal spell
augroup END
"}}}

" syntax {{{
syntax enable
set iskeyword+=- " treat dash separated words as a word text object.
augroup vimrc_syntax
  autocmd!
  autocmd BufRead setup.cfg setlocal filetype=toml
augroup END
"}}}

" undo {{{
set undofile
set undodir=${HOME}/.local/share/nvim/undo
if !isdirectory(&undodir) | call mkdir(&undodir, 'p', 0700) | endif
"}}}

" whitespace {{{
set list
set listchars=tab:>-,trail:·
augroup vimrc_whitespace
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufWritePre * %s/\n\+\%$//e
augroup END
"}}}

" misc {{{
set mouse=a
set hidden
set cursorline
set foldmethod=marker
set number
set relativenumber
set splitbelow splitright
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

" test.
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

" easy-align.
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

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
nnoremap Y y$
nnoremap <silent> <leader>z :Goyo<CR>
nnoremap <leader>s  :%s/\<<C-r><C-w>\>//g<Left><Left>
tnoremap <Esc> <C-\><C-n>

"}}}
