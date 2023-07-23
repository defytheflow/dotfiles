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

Plug 'ThePrimeagen/vim-be-good'

" Dashboard.
Plug 'nvimdev/dashboard-nvim'

" Git signs/decorations.
Plug 'lewis6991/gitsigns.nvim'

" Displays available keybindings.
Plug 'folke/which-key.nvim'
nnoremap <silent> <leader> :WhichKey <leader><CR>

" Zen mode.
Plug 'folke/zen-mode.nvim'
nnoremap <leader>z <cmd>ZenMode<CR>

" Dims inactive portions of the code.
Plug 'folke/twilight.nvim'

" Outline window.
Plug 'stevearc/aerial.nvim'
nnoremap <leader>o <cmd>AerialToggle!<CR>

" Netrw file icons.
Plug 'prichrd/netrw.nvim'

" Terminal toggle.
" Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" Indent guides.
" Plug 'lukas-reineke/indent-blankline.nvim'

" neovim colorschemes.
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'tanvirtin/monokai.nvim'
Plug 'arzg/vim-colors-xcode'

" Colored icons. Used by bufferline.nvim, lualine.nvim, telescope.nvim and netrw.nvim
Plug 'nvim-tree/nvim-web-devicons'

" Buffer line.
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }

" Status line.
Plug 'nvim-lualine/lualine.nvim' " NOTE: because of this plugin, default dashboard page disappears

" syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'JoosepAlviste/nvim-ts-context-commentstring' " jsx/tsx comments
Plug 'windwp/nvim-ts-autotag' " auto close tags

" Fuzzy finder.
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'fannheyward/telescope-coc.nvim'
Plug 'xiyaowong/telescope-emoji.nvim'
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fd <cmd>Telescope coc diagnostics<cr>
nnoremap <leader>fe <cmd>Telescope emoji<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fs <cmd>Telescope coc document_symbols<cr>

" Todo commments.
Plug 'folke/todo-comments.nvim'
nnoremap <leader>ft :TodoTelescope<cr>

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
" Plug 'bkad/CamelCaseMotion'
" let g:camelcasemotion_key = '<leader>'

Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

" Preview markdown on your browser.
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
nmap <leader>mp <Plug>MarkdownPreviewToggle

" Enables emoji abbreviations, digraphs and completion.
Plug 'https://gitlab.com/gi1242/vim-emoji-ab.git'
" It has a runtime command at the bottom of the file.

" Automatically inserts the closing tag.
" Plug 'alvan/vim-closetag'
" let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.tsx'
" let g:closetag_filetypes = 'html,xhtml,jsx'
" " let g:closetag_close_shortcut = '<leader>>'
" let g:closetag_regions =  {
" \ 'typescript.tsx': 'jsxRegion,tsxRegion',
" \ 'javascript.jsx': 'jsxRegion',
" \ }

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

" Git plugin.
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
set previewheight=22

" Git log browser (depends on vim-fugitive ^^^)
Plug 'junegunn/gv.vim'
nnoremap <leader>gl :GV<CR>

" Shows git diff in the sign column.
" Plug 'airblade/vim-gitgutter'

" Displays vertical lines and dots at each indentation level.
" Plug 'Yggdroot/indentLine'
" let g:indentLine_leadingSpaceChar = '·'
" let g:indentLine_leadingSpaceEnabled = '1'
" let g:indentLine_fileTypeExclude = ['text', 'vimwiki']

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

" Displays a floating terminal.
Plug 'voldikss/vim-floaterm'

" Switch between alternative files.
Plug 'tpope/vim-projectionist'

" Personal wiki.
Plug 'vimwiki/vimwiki'

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

" Python text objects and motions.
Plug 'jeetsukumaran/vim-pythonsense', { 'for': 'python' }

" Python indentation that complies with pep8.
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
let g:python_pep8_indent_hang_closing = 0

" text objects.
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
  colorscheme tokyonight-moon
  " colorscheme tokyonight-day
  " Good ones:
  " colorscheme night-owl
  " colorscheme base16-classic-dark
  " colorscheme base16-gruvbox-dark-hard
  " colorscheme gruvbox
  " colorscheme base16-ocean
catch
  colorscheme koehler
endtry

" command-line.
set wildmenu
set wildmode=longest,list,full
set wildignore+=*/.git/*,*/.venv/*,*/node_modules/*,*cache*,*coverage*
set wildignorecase

" fold.
set foldmethod=marker

" gui.
set guifont=FiraCode:h11

" cursor.
set guicursor=i:block

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
" set listchars+=trail:•
set listchars+=nbsp:⦸
set listchars+=extends:»
set listchars+=precedes:«
" set listchars=lead:·
" set listchars+=eol:↴

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

" center the screen after a cursor jump.
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

" netrw.
nnoremap <leader>n :Lex<CR>

" misc.
nnoremap <leader>d :bd!<CR>
nnoremap <leader>mk :w \| :make<CR>

" visual.
vnoremap < <gv
vnoremap > >gv
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

" Note: When you decide to put autocmds for saving folds state, make sure that nohlsearch
" and Telescope find_files still work.

augroup vimrc_highlight_yank
  au!
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=200}
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
  au SourcePost  $MYVIMRC call InstallPlugins()
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
