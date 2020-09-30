scriptencoding utf-8

" File:     init.vim
" Created:  30.12.2019
" Author:   Artyom Danilov (@defytheflow)

let g:mapleader = '\'

if filereadable('/usr/bin/python3')
  let g:python3_host_prog = '/usr/bin/python3'
endif

let config_dir = has('nvim') ? stdpath('config') : glob('~/.vim')
let cache_dir = has('nvim') ? stdpath('cache') : glob('~/.vim')

let vimplug = config_dir . '/autoload/plug.vim'
if !filereadable(vimplug)
  let url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  silent exec '!curl -fLo ' . vimplug . ' --create-dirs ' . url
endif

" plugins {{{
call plug#begin(config_dir . '/plugged')

" ale {{{
Plug 'dense-analysis/ale'
runtime ale.vim
"}}}

" camel-case-motion {{{
Plug 'bkad/CamelCaseMotion'
let g:camelcasemotion_key = '<leader>'
"}}}

" ccls {{{
Plug 'm-pilia/vim-ccls'
let g:ccls_close_on_jump = v:true
"}}}

" closetag {{{
Plug 'alvan/vim-closetag'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx,*js'
let g:closetag_filetypes = 'html,xhtml,phtml,jsx,tsx'
"}}}

" ctrlp {{{
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '.git\|.venv\|node_modules\|htmlcov\|plugged'
nnoremap <silent> gb :CtrlPBuffer<CR>
"}}}

" deoplete {{{
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
"}}}

" delimitmate {{{
Plug 'Raimondi/delimitMate'
let delimitMate_matchpairs = '(:),[:],{:}'
"}}}

" easyalign {{{
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

" indentline {{{
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

" nerdtree {{{
Plug 'preservim/nerdtree'
let g:NERDTreeWinSize = 30
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI  = 1  " Disable '?' help at the top
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeBookmarksFile = cache_dir . '/NERDTreeBookmarks'
let g:NERDTreeIgnore = [
\  'htmlcov',
\  '.git', '.idea',
\  '__pycache__', '.mypy_cache', '.pytest_cache'
\]
augroup vimrc_nerdtree
  autocmd!
  autocmd BufEnter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
augroup END
nnoremap <silent> <leader>f :NERDTreeToggle<CR>
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

" quickscope {{{
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
"}}}

" colorschemes {{{
Plug 'tomasiser/vim-code-dark'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
"}}}

" syntax {{{
Plug 'vim-python/python-syntax'
let g:python_highlight_all = 1
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'mboughaba/i3config.vim'
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
Plug 'jremmen/vim-ripgrep'
"}}}

call plug#end()
"}}}

" settings {{{

" backup {{{
set backup
set noswapfile
set backupdir=${HOME}/.local/share/nvim/backup
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p', 0700)
endif
"}}}

" colorscheme {{{
set termguicolors " use guifg/guibg instead of ctermfg/ctermfb in terminal.
set background=dark
try
  colorscheme base16-gruvbox-dark-hard
catch
  colorscheme koehler
endtry
"}}}

" command-line {{{
set history=1000
set wildmenu
set wildmode=longest,list,full
set wildignore+=__pycache__,.mypy_cache,.pytest_cache
set wildignorecase
"}}}

" fold {{{
set foldmethod=marker
augroup vimrc_fold
  autocmd!
  autocmd FileType python setlocal foldmethod=indent
augroup END
"}}}

" gui {{{
set guifont=FiraCode:h11
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
augroup vimrc_syntax
  autocmd!
  autocmd BufNewFile,BufRead setup.cfg setlocal filetype=toml
  autocmd BufNewFile,BufRead ~/.config/i3/config setlocal filetype=i3config
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
set undodir=${HOME}/.local/share/nvim/undo
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

" buffers. {{{
nnoremap <silent> <tab>   :bn<CR>
nnoremap <silent> <S-tab> :bp<CR>
"}}}

" vim. {{{
nnoremap <silent> <leader>ve :e $MYVIMRC<CR>
nnoremap <silent> <leader>vs :so $MYVIMRC<CR>
"}}}

" search. {{{
nnoremap / /\v
vnoremap / /\v
"}}}

" visual. {{{
vnoremap < <gv
vnoremap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
"}}}

" misc. {{{
nnoremap <leader><leader> <C-^>
nnoremap <leader>s  :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <leader>q :quit<CR>
nnoremap <silent> <C-l> :nohl<CR>
nnoremap <silent> <C-s> :w<CR>
nnoremap Y y$
nnoremap Q <nop>
tnoremap <Esc> <C-\><C-n>
"}}}

"}}}
