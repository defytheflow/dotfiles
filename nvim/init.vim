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

" syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" Fuzzy finder.
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" LSP, completion, diagnostics, refactoring, snippets.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver'
Plug 'neoclide/coc-highlight'
Plug 'neoclide/coc-snippets'
Plug 'neoclide/coc-json'
Plug 'honza/vim-snippets'

" Linting and formatting.
" Plug 'dense-analysis/ale'

" Defines camelCase and snake_keys motions (w, b, e).
Plug 'bkad/CamelCaseMotion'
let g:camelcasemotion_key = '<leader>'

Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

" Preview markdown on your browser.
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
nmap <leader>mp <Plug>MarkdownPreviewToggle

" Enables emoji abbreviations, digraphs and completion.
Plug 'https://gitlab.com/gi1242/vim-emoji-ab.git'
" It has a runtime command at the bottom of the file.

" Plug 'junegunn/vim-emoji'
" Make sure to declare it after vim-plug plugins block.
" set completefunc=emoji#complete

" Automatically inserts the closing tag.
" Plug 'alvan/vim-closetag'
" let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.tsx'
" let g:closetag_filetypes = 'html,xhtml,jsx'
" " let g:closetag_close_shortcut = '<leader>>'
" let g:closetag_regions =  {
" \ 'typescript.tsx': 'jsxRegion,tsxRegion',
" \ 'javascript.jsx': 'jsxRegion',
" \ }

" Automatically renames closing/opening tags.
Plug 'AndrewRadev/tagalong.vim'

" Aligns text.
Plug 'junegunn/vim-easy-align'
let g:easy_align_ignore_groups = []
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Fuzzy finder.
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" map <silent> <C-p> :Files<CR>
" map <silent> <C-p> :execute system('git rev-parse --is-inside-work-tree') =~ 'true' ? 'GFiles' : 'Files' <CR>
" nnoremap <silent> gb        :Buffers<CR>
" nnoremap <silent> <leader>b :Buffers<CR>

" Zen mode.
Plug 'junegunn/goyo.vim'

" Git plugin.
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
set previewheight=22

" Git log browser (depends on vim-fugitive ^^^)
Plug 'junegunn/gv.vim'
nnoremap <leader>gl :GV<CR>

" Shows git diff in the sign column.
Plug 'airblade/vim-gitgutter'

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
" Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

" Highlights unique characters in every word to easier use f, F, t and T.
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Runs tests.
Plug 'vim-test/vim-test'

" Emmet support.
" Plug 'mattn/emmet-vim'
" uses <C-Y> which conflicts with vim built-in

" Code Snippets. (coc does that)
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Highlights colornames and codes. (coc does that)
"  Plug 'chrisbra/Colorizer'
"  let g:colorizer_auto_filetype='css,html,js,text,scss'
"  let g:colorizer_use_virtual_text = 1

" Displays available keybindings.
Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <leader> :WhichKey '\'<CR>

" Displays a floating temrinal.
Plug 'voldikss/vim-floaterm'

" Switch between alternative files.
Plug 'tpope/vim-projectionist'

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

" Plug 'danro/rename.vim'
" Plug 'miyakogi/seiya.vim'

" Python.

" Python folding.
" Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
" let g:SimpylFold_docstring_preview = 1
" let g:SimpylFold_fold_docstring = 0
" let g:SimpylFold_fold_import = 0

" Python text objects and motions.
Plug 'jeetsukumaran/vim-pythonsense', { 'for': 'python' }

" Python syntax highlighting.
" Plug 'vim-python/python-syntax', { 'for': 'python' }
" let g:python_highlight_all = 1

" Python indentation that complies with pep8.
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
let g:python_pep8_indent_hang_closing = 0

" text objects.
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'michaeljsmith/vim-indent-object'
Plug 'wellle/targets.vim' " adds i/ finally!

" colorschemes.
Plug 'tomasiser/vim-code-dark'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'haishanh/night-owl.vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

" syntaxes.
" Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mboughaba/i3config.vim'
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
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
  " colorscheme base16-classic-dark
  " colorscheme base16-gruvbox-dark-hard
  " colorscheme gruvbox
  " colorscheme base16-ocean
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
set softtabstop=2
set shiftwidth=2
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
set lazyredraw " don't redraw while executing macros.
set timeoutlen=500
set noerrorbells visualbell t_vb=

" netrw.
" Keep the current directory and the browsing directory synced.
" This helps avoid the move files error.
let g:netrw_keepdir = 0

" Change the size to 30% when netrw creates a split.
let g:netrw_winsize = 30

" Highlight marked files in the same way search matches are.
hi link netrwMarkFile Search
"}}}

" mappings {{{

" vimrc.
command! Rld :source $MYVIMRC
nnoremap <silent> <leader>ve :edit   $MYVIMRC<CR>
nnoremap <silent> <leader>vs :split  $MYVIMRC<CR>
nnoremap <silent> <leader>vv :vsplit $MYVIMRC<CR>

" move to the next/previous search result and center the screen.
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" visual.
vnoremap < <gv
vnoremap > >gv

" misc.
tnoremap <Esc> <C-\><C-n>
"}}}

" autocmds {{{
augroup vimrc_syntax
  au!
  au BufNewFile,BufRead setup.cfg             setlocal filetype=toml
  au BufNewFile,BufRead .prettierrc,.eslintrc setlocal filetype=json
  au BufNewFile,BufRead ~/.config/i3/config   setlocal filetype=i3config
  au BufNewFile,BufRead coc-settings.json     setlocal filetype=jsonc
  au BufNewFile,BufRead tsconfig.json         setlocal filetype=jsonc
  " vscode configuration files.
  au BufNewFile,BufRead settings.json         setlocal filetype=jsonc
  au BufNewFile,BufRead keybindings.json      setlocal filetype=jsonc
  au BufNewFile,BufRead *code-snippets        setlocal filetype=jsonc
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

" augroup vimrc_folds
"   autocmd!
"   autocmd BufWinLeave * mkview
"   autocmd BufWinEnter * silent! loadview
" augroup END

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
  au BufReadPost *.bin set filetype=xxd | endif

  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif

  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END
"}}}

digraph P! 129383 " pie emoji 🥧
digraph R! 128640 " rocket emoji 🚀
digraph T! 129394 " smiling face with tear emoji 🥲
digraph OO 129417 " owl emoji 🦉

" Enables emoji abbreviations and completion (vim-emoji-ab plugin)
" Can't be declared inside vim-plug plugins block, gets overwritten by other plugins or something.
" This enables the plugin inside files that don't have a filetype, like unsaved files.
runtime macros/emoji-ab.vim
augroup vimrc_emoji_ab
  au!
  " This enables the plugin inside files that have a filetype.
  au FileType * runtime macros/emoji-ab.vim
  " au FileType html,markdown,text,gitcommit runtime macros/emoji-ab.vim
augroup END
