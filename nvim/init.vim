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

" Lsp, completion, diagnostics, refactoring, snippets.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver'
Plug 'neoclide/coc-highlight'
Plug 'neoclide/coc-snippets'
Plug 'honza/vim-snippets'
runtime coc.vim

" Linting and formatting.
Plug 'dense-analysis/ale'
runtime ale.vim

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

" Completion.
"  if has('nvim')
"    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"  else
"    Plug 'Shougo/deoplete.nvim'
"    Plug 'roxma/nvim-yarp'
"    Plug 'roxma/vim-hug-neovim-rpc'
"  endif
"  let g:deoplete#enable_at_startup = 0
"  call deoplete#custom#option({'smart_case': v:true})
"  call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment'])

"  Plug 'junegunn/vim-after-object'
"  augroup vimrc_after_object
"    au!
"    au VimEnter * call after_object#enable('=', ':', '-', '#', ' ')
"  augroup END

" Aligns text.
Plug 'junegunn/vim-easy-align'
let g:easy_align_ignore_groups = []
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Fuzzy finder.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
map <silent> <C-p> :Files<CR>
" map <silent> <C-p> :execute system('git rev-parse --is-inside-work-tree') =~ 'true' ? 'GFiles' : 'Files' <CR>
" nnoremap <silent> gb        :Buffers<CR>
" nnoremap <silent> <leader>b :Buffers<CR>

" Zen mode.
Plug 'junegunn/goyo.vim'
runtime goyo.vim

" Git plugin.
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>

" Git log browser (depends on vim-fugitive ^^^)
Plug 'junegunn/gv.vim'
nnoremap <leader>gl :GV<CR>

" Shows git diff in the sign column.
Plug 'airblade/vim-gitgutter'
runtime gitgutter.vim

" Highlights yank operations.
Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 200

" Displays vertical lines and dots at each indentation level.
Plug 'Yggdroot/indentLine'
let g:indentLine_char =  '¦'
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = '1'
let g:indentLine_fileTypeExclude = ['text', 'vimwiki']

" File system explorer.
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
runtime nerdtree.vim

" Highlights unique characters in every word to easier use f, F, t and T.
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Runs tests.
Plug 'vim-test/vim-test'
runtime test.vim

" Emmet support.
Plug 'mattn/emmet-vim'

" Code Snippets. (coc does that)
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" runtime ultisnips.vim

" Highlights colornames and codes. (coc does that)
"  Plug 'chrisbra/Colorizer'
"  let g:colorizer_auto_filetype='css,html,js,text,scss'
"  let g:colorizer_use_virtual_text = 1

" Displays available keybindings.
Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <leader> :WhichKey '\'<CR>

" Displays a floating temrinal.
Plug 'voldikss/vim-floaterm'
runtime floaterm.vim

" Switch between alternative files.
Plug 'tpope/vim-projectionist'
runtime projectionist.vim

" Personal wiki.
Plug 'vimwiki/vimwiki'

" Status line.
Plug 'itchyny/lightline.vim'

" Auto close quotes and parentheses.
Plug 'cohama/lexima.vim'

" Comment stuff out with gc.
Plug 'tpope/vim-commentary'

" Enable repeating plugin mappings with \"."
Plug 'tpope/vim-repeat'

" Delete/change/add parentheses/quotes/tags.
Plug 'tpope/vim-surround'

" Pairs of handy bracket mappings.
Plug 'tpope/vim-unimpaired'

" Replace text witht he contents of a register.
Plug 'inkarkat/vim-ReplaceWithRegister'

" Jump to any location specified by two characters.
Plug 'justinmk/vim-sneak'

" Plug 'danro/rename.vim'
" Plug 'miyakogi/seiya.vim'

" Python.

" Python text objects and motions.
Plug 'jeetsukumaran/vim-pythonsense', { 'for': 'python' }

" Python syntax highlighting.
Plug 'vim-python/python-syntax', { 'for': 'python' }
let g:python_highlight_all = 1

" Python indentation that complies with pep8.
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
let g:python_pep8_indent_hang_closing = 0

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
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
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

digraph R! 128640 " rocket emoji.
digraph T! 129394 " smilint face with tear emoji.
digraph OO 129417 " owl emoji.
