
" Filename:     plugin.vim
" Description:  Pluggins download and settings.

" Created:      29.03.2020
" Author:       Artyom Danilov


" Download vim-plug + {{{
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

Plug 'airblade/vim-gitgutter'           " Git stats in number column.
Plug 'tpope/vim-fugitive'               " Git commands.
Plug 'ctrlpvim/ctrlp.vim'               " Fuzzy find files.
Plug 'jiangmiao/auto-pairs'             " Auto-completion of quotes, brackets.
Plug 'alvan/vim-closetag'               " Auto-completion of html tags.
Plug 'othree/xml.vim'                   " Auto-completion of xml tags.
Plug 'tpope/vim-surround'               " Edit quotes, parentheses, tags.
Plug 'tpope/vim-commentary'             " Commenting.
Plug 'unblevable/quick-scope'           " Horizontal navigation.
Plug 'mhinz/vim-startify'               " Start screen.
Plug 'ron89/thesaurus_query.vim'        " Word synonyms.
Plug 'vimwiki/vimwiki'                  " Note taking.
Plug 'inkarkat/vim-ReplaceWithRegister' " Text object replacement.
Plug 'sheerun/vim-polyglot'             " Syntax highlight.

" Pymode {{{
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" Code checking.
let g:pymode_lint = 0

" Syntax.
let g:pymode_syntax_print_as_function = 1
"}}}

" Taglist {{{
Plug 'vim-scripts/taglist.vim'

let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
"}}}

" Vim-snippets (Snippets engline) {{{
Plug 'SirVer/ultisnips'    " Engline
Plug 'honza/vim-snippets'  " Snippets

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
"}}}

" Syntastic (Syntax Errors) {{{
Plug 'vim-syntastic/syntastic'

" Load errors into the location list to jump between them.
let g:syntastic_always_populate_loc_list = 1
" Check for errors when file is opened.
let g:syntastic_check_on_open = 0
" Check for errors when file is saved.
let g:syntastic_check_on_wq = 1
" Indicate a line with error.
" let g:syntastic_error_symbol = "✗"
let g:syntastic_ignore_files = ['[a-z][A-Z][0-9]*.asm']
" Check python3 syntax.
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['mypy', 'pylint']
let g:syntastic_python_flake8_post_args='--ignore=E501'
"}}}

" Deoplete (Auto-completion engine) {{{
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

let g:deoplete#enable_at_startup = 1
"}}}

" Java-complete {{{
Plug 'artur-shaik/vim-javacomplete2'

autocmd FileType java setlocal omnifunc=javacomplete#Complete
let g:JavaComplete_ClosingBrace = 0
"}}}

" Better-whitespace (Extra whitespace) {{{
Plug 'ntpeters/vim-better-whitespace'

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
"}}}

" Indent-line (Indentation display) {{{
Plug 'Yggdroot/indentLine'

let g:indentLine_char =  '¦'
let g:indentLine_leadingSpacChar='·'
let g:indentLine_leadingSpaceEnabled='1'
"}}}

" Nerdtree (File tree) {{{
Plug 'preservim/nerdtree'

" Show hidden files.
let NERDTreeShowHidden = 1
" Disable '?' help at the top
let NERDTreeMinimalUI  = 1
" Automatically delete the buffer of the file you just deleted.
let NERDTreeAutoDeleteBuffer = 1
" Don't show these entries.
let NERDTreeIgnore=['__pycache__', '.git', '.mypy_cache', '.idea']

" Tab settings for nerdtree.
Plug 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_console_startup = 2
let g:nerdtree_tabs_autoclose = 0

" Icon settings for nerdtree.
Plug 'ryanoasis/vim-devicons'
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
"}}}

" Airline (Status line) {{{
Plug 'vim-airline/vim-airline'

" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1
" Display hunks if the diff is non-zero.
let g:airline#extensions#hunks#non_zero_only = 1
"}}}

" Limelight (Focus mode) {{{
Plug 'junegunn/limelight.vim'

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
"}}}

" Goyo (Focus mode) {{{
Plug 'junegunn/goyo.vim'

function! s:goyo_enter()
    set noshowmode
    set noshowcmd
    Limelight
endfunction

function! s:goyo_leave()
    set showmode
    set showcmd
    Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
"}}}

" Seiya (Transparent background) {{{
Plug 'miyakogi/seiya.vim'

let g:seiya_auto_enable=1
"}}}

" Colorschemes {{{

" Classic
Plug 'tomasiser/vim-code-dark'          " codedark (VsCode default)
Plug 'doums/darcula'                    " darcula  (PyCharm default)
Plug 'morhetz/gruvbox'                  " grubbox
Plug 'tomasr/molokai'                   " molokai
Plug 'sickill/vim-monokai'              " monokai  (Sublime default)

" Other
Plug 'AlessandroYorba/Alduin'           " alduin
let g:alduin_Shout_Become_Ethereal = 1
let g:alduin_Shout_Fire_Breath = 1
Plug 'atahabaki/archman-vim'            " archman
Plug 'dracula/vim'                      " dracula
Plug 'habamax/vim-colors-lessthan'      " lessthan
Plug 'bluz71/vim-nightfly-guicolors'    " nightfly
Plug 'drewtempelmeyer/palenight.vim'    " palenight

"}}}

call plug#end()

" Man pages (Do not surround with quotes!)
runtime ftplugin/man.vim
