
" Filename:     plugin.vim
" Description:  Plugins

" Created:      29.03.2020
" Author:       Artyom Danilov


" Install plugin manager {{{
if !filereadable($HOME . '/.config/nvim/autoload/plug.vim')
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
"}}}

" Install missing pluggins {{{
let g:plugged_home = $HOME . '/.config/nvim/plugged/'
for plugin in ['vim-surround', 'vim-commentary', 'goyo.vim', 'quick-scope',
\              'syntastic', 'deoplete.nvim', 'deoplete-jedi', 'auto-pairs',
\              'indentLine', 'nerdtree', 'vim-devicons',
\              'vim-airline', 'molokai', 'vim-atom-dark', 'palenight.vim']
    if !isdirectory(g:plugged_home . plugin)
        autocmd VimEnter * PlugInstall | source $MYVIMRC
        break
    endif
endfor
"}}}

call plug#begin(g:plugged_home)

Plug 'tpope/vim-surround'      " Quotes, parentheses, tags.
Plug 'tpope/vim-commentary'    " Commenting.
Plug 'junegunn/goyo.vim'       " Center text.
Plug 'unblevable/quick-scope'  " Horizontal navigation.

" Syntax {{{
Plug 'vim-syntastic/syntastic'
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
"}}}

" Autocompletion {{{
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

Plug 'deoplete-plugins/deoplete-jedi'  " Python.
Plug 'jiangmiao/auto-pairs'  " Quotes and Brackets.
"}}}

" Indentation  {{{
Plug 'Yggdroot/indentLine'
let g:indentLine_char =  '¦'
let g:indentLine_leadingSpacChar='·'
let g:indentLine_leadingSpaceEnabled='1'
"}}}

" NERDTree {{{
Plug 'preservim/nerdtree'
let NERDTreeShowHidden = 1  " Show hiden files/directories.
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeAutoDeleteBuffer = 1
" Don't show these files/directories.
let NERDTreeIgnore=['__pycache__']
" Automatically close nerdtree tab if it is the only window left.
autocmd bufenter *
    \ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Filetype icons for nerdtree.
Plug 'ryanoasis/vim-devicons'
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
"}}}

" Statusline/Tabline {{{
Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
"}}}

" Colorshemes {{{
Plug 'tomasr/molokai'
Plug 'gosukiwi/vim-atom-dark'
Plug 'drewtempelmeyer/palenight.vim'
"}}}

call plug#end()
"
" Man pages (Do not surround with quotes!)
runtime ftplugin/man.vim
