
" File:     plugins.vim
" Created:  29.03.2020
" Author:   Artyom Danilov


" Download vim-plug {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
"}}}

" Download pluggins + {{{
autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif
"}}}

call plug#begin($HOME . '/.config/nvim/plugged/')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'

Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'michaeljsmith/vim-indent-object'

Plug 'airblade/vim-gitgutter'           " git stats in number column.
Plug 'jiangmiao/auto-pairs'             " auto-complete quotes, brackets.
Plug 'unblevable/quick-scope'           " horizontal navigation.
Plug 'inkarkat/vim-ReplaceWithRegister' " text object replacement.
Plug 'sheerun/vim-polyglot'             " syntax highlight.
Plug 'vim-scripts/a.vim'                " switch between .c --> .h
Plug 'miyakogi/seiya.vim'               " transparent background.

Plug 'bkad/CamelCaseMotion'
let g:camelcasemotion_key = '<leader>'

" airline {{{
Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='luna'
"}}}

" better-whitespace {{{
Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
"}}}

" closetag {{{
Plug 'alvan/vim-closetag'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx,*js'
let g:closetag_filetypes = 'html,xhtml,phtml,jsx,tsx'
"}}}

" ctrlp {{{
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
"}}}

" deoplete {{{
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
"}}}

" indentline {{{
Plug 'Yggdroot/indentLine'
let g:indentLine_char =  '¦'
let g:indentLine_leadingSpacChar='·'
let g:indentLine_leadingSpaceEnabled='1'
"}}}

" nerdtree {{{
Plug 'preservim/nerdtree'
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI  = 1  " Disable '?' help at the top
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore=['__pycache__', '.git', '.mypy_cache', '.idea']
let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
Plug 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_console_startup = 2
let g:nerdtree_tabs_autoclose = 0
Plug 'ryanoasis/vim-devicons'
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
"}}}

" snippets {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = '<tab>'
"}}}

call plug#end()

" Man pages (Do not surround with quotes!)
runtime ftplugin/man.vim
