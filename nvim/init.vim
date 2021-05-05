scriptencoding utf-8

" File:     init.vim
" Created:  30.12.2019
" Author:   Artyom Danilov (@defytheflow)

let g:mapleader = '\'

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

Plug 'dense-analysis/ale'
runtime ale.vim

Plug 'bkad/CamelCaseMotion'
runtime camelcase.vim

Plug 'alvan/vim-closetag'
runtime closetag.vim

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
runtime deoplete.vim

Plug 'junegunn/vim-after-object'
augroup vimrc_after_object
  au!
  au VimEnter * call after_object#enable('=', ':', '-', '#', ' ')
augroup END

Plug 'junegunn/vim-easy-align'
let g:easy_align_ignore_groups = []
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
runtime fzf.vim

Plug 'junegunn/goyo.vim'
runtime goyo.vim

Plug 'junegunn/gv.vim'
Plug 'tpope/vim-fugitive'
runtime fugitive.vim

Plug 'airblade/vim-gitgutter'
runtime gitgutter.vim

Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 200

Plug 'Yggdroot/indentLine'
runtime indentline.vim

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
runtime nerdtree.vim

Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

Plug 'vim-test/vim-test'
runtime test.vim

Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
runtime ultisnips.vim

Plug 'chrisbra/Colorizer'
let g:colorizer_auto_filetype='css,html,js,text,scss'
let g:colorizer_use_virtual_text = 1

Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <leader> :WhichKey '\'<CR>

Plug 'voldikss/vim-floaterm'
runtime floaterm.vim

Plug 'tpope/vim-projectionist'
runtime projectionist.vim

Plug 'danro/rename.vim'
Plug 'vimwiki/vimwiki'
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

" syntaxes.
Plug 'mboughaba/i3config.vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'uiiaoo/java-syntax.vim', { 'for': 'java' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'cespare/vim-toml', { 'for': 'toml' }

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
  colorscheme base16-classic-dark
  " Good ones:
  " base16-classic-dark
  " base16-gruvbox-dark-hard
catch
  colorscheme koehler
endtry
" hi Normal guibg=none

" command-line.
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
set hlsearch
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
set scrolloff=10
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
set clipboard+=unnamedplus " use system clipboard.
set lazyredraw " don't redraw while executing macros.
set timeoutlen=500
set noerrorbells visualbell t_vb=
"}}}
