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

call plug#begin(config_dir . '/plugged')

Plug 'ThePrimeagen/vim-be-good'

" Open files at last edit location
Plug 'farmergreg/vim-lastplace'

" Undo history visualizer
Plug 'mbbill/undotree'

" File explorer
Plug 'nvim-tree/nvim-tree.lua'

" Highlight trailing whitespace
Plug 'echasnovski/mini.trailspace'

" Generate JSDoc comments
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx','typescript'],
  \ 'do': 'make install'
\}

" Dashboard.
Plug 'nvimdev/dashboard-nvim'

" Git signs/decorations.
Plug 'lewis6991/gitsigns.nvim'

" Git plugin.
Plug 'tpope/vim-fugitive'

" Git log browser (depends on vim-fugitive ^^^)
Plug 'junegunn/gv.vim'

" Displays available keybindings.
Plug 'folke/which-key.nvim'

" Zen mode.
Plug 'folke/zen-mode.nvim'

" Dims inactive portions of the code.
Plug 'folke/twilight.nvim'

" Outline window.
Plug 'stevearc/aerial.nvim'

" Netrw file icons.
Plug 'prichrd/netrw.nvim'

" Terminal toggle.
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" Indent guides.
Plug 'lukas-reineke/indent-blankline.nvim'

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
" NOTE: Adds closing jsx tags every time I hit /, even if the tag is already completed
" and I am editing within it.
" Plug 'windwp/nvim-ts-autotag' " auto close tags

" Fuzzy finder.
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'fannheyward/telescope-coc.nvim'
Plug 'xiyaowong/telescope-emoji.nvim'

" Todo commments.
Plug 'folke/todo-comments.nvim'

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

" Preview markdown in your browser.
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }

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

" Automatically renames closing/opening tags.
Plug 'AndrewRadev/tagalong.vim'

" Aligns text.
Plug 'junegunn/vim-easy-align'
let g:easy_align_ignore_groups = []
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

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

" Text object for entire buffer
Plug 'kana/vim-textobj-entire' " needs `kana/vim-textobj-user` to work
Plug 'kana/vim-textobj-user'

" Text object for lines at the same indent level
Plug 'michaeljsmith/vim-indent-object'

" Text objects like `i/`
Plug 'wellle/targets.vim'

" colorschemes.
Plug 'tomasiser/vim-code-dark'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'haishanh/night-owl.vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

" syntaxes.
Plug 'mboughaba/i3config.vim'
Plug 'uiiaoo/java-syntax.vim', { 'for': 'java' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'pantharshit00/vim-prisma'

call plug#end()

fun! InstallPlugins()
  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    PlugInstall --sync | q
  endif
endfun

augroup vimrc_misc
  au!
  au SourcePost  $MYVIMRC call InstallPlugins()
augroup END
