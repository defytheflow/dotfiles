" File:      plugin.vim
" Purpose:   add plugins
" Created:   29.03.2020
" Modified:  29.03.2020
" Author:    Artyom Danilov


" If plug vim is not presend -> download it.
if ! filereadable(expand('~/.vim/autoload/plug.vim'))
    echo "Downloading 'vim-plug' to manage plugins..."
    silent !mkdir -p ~/.vim/autoload/
    silent !curl 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' > ~/.vim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

" Quotes, tags, parentheses
Plug 'tpope/vim-surround'

" Comments.
Plug 'tpope/vim-commentary'

" File manipulation.
Plug 'tpope/vim-eunuch'

" Git.
Plug 'tpope/vim-fugitive'

" Center text.
Plug 'junegunn/goyo.vim'

" Horizontal text navigation.
Plug 'unblevable/quick-scope'

" File system explorer.
Plug 'preservim/nerdtree'
let NERDTreeShowHidden = 1

" Status line.
Plug 'itchyny/lightline.vim'

" Colorshemes.
Plug 'tomasr/molokai'
Plug 'gosukiwi/vim-atom-dark'
Plug 'drewtempelmeyer/palenight.vim'

call plug#end()

" Man pages (Do not surround with quotes!)
runtime ftplugin/man.vim
