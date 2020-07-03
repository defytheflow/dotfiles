
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

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'

Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'

Plug 'airblade/vim-gitgutter'           " git stats in number column.
Plug 'jiangmiao/auto-pairs'             " auto-complete quotes, brackets.
Plug 'unblevable/quick-scope'           " horizontal navigation.
Plug 'vimwiki/vimwiki'                  " note taking.
Plug 'inkarkat/vim-ReplaceWithRegister' " text object replacement.
Plug 'sheerun/vim-polyglot'             " syntax highlight.
Plug 'majutsushi/tagbar'                " tagbar.

" c/c++ {{{
Plug 'vim-scripts/a.vim'  " switch between .c --> .h
Plug 'arakashic/chromatica.nvim'
let g:chromatica#libclang_path='/usr/lib/llvm-3.9/lib/'
let g:chromatica#enable_at_startup=1
Plug 'rhysd/vim-clang-format'
let g:clang_format#style_options = {
    \ "AccessModifierOffset" : -4,
    \ "AlignConsecutiveAssignments": "false",
    \ "AlignConsecutiveDeclarations": "false",
    \ "AllowShortIfStatementsOnASingleLine" : "true",
    \ "AllowShortCaseLabelsOnASingleLine": "true",
    \ "AllowShortFunctionsOnASingleLine" : "false",
    \ "BreakBeforeBraces" : "Stroustrup",
    \ "ColumnLimit" : 90,
    \ "IndentWidth" : 4,
    \ "MaxEmptyLinesToKeep": 2,
    \ "SpacesBeforeTrailingComments": 2,
    \ "SpaceAfterCStyleCast": "true",
    \ "IndentCaseLabels": "false",
    \ "UseTab" : "Never"}
autocmd FileType c ClangFormatAutoEnable
" }}}

" java {{{
Plug 'artur-shaik/vim-javacomplete2'
autocmd FileType java setlocal omnifunc=javacomplete#Complete
let g:JavaComplete_ClosingBrace = 0
"}}}

" typescript {{{
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
"}}}

Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'

Plug 'dense-analysis/ale'
let g:ale_linters = {
            \   'python': ['pylint'],
            \   'javascript': ['eslint'],
            \}
let g:ale_fixers = {
            \    'python': ['isort', 'black'],
            \    'javascript': ['prettier', 'eslint']
            \}

let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_python_pylint_use_global = 1

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

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
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml,jsx,tsx'
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
"}}}

" ctrlp {{{
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
"}}}

" deoplete {{{
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-clang'
Plug 'deoplete-plugins/deoplete-jedi'
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
