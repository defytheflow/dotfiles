" Name:      plugin.vim
" Purpose:   Move plugin related stuff to a separate place.
" Use:       Sourced by .vimrc
" Created:   29.03.2020
" Modified:  30.03.2020
" Author:    Artyom Danilov


" Plugin manager
" ------------------------------------------------------------------------------
" If 'vim-plug' is not installed -> download it.
if ! filereadable(expand('~/.vim/autoload/plug.vim'))
    echo "Downloading 'vim-plug' to manage plugins..."
    silent !mkdir -p ~/.vim/autoload/
    silent !curl 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' > ~/.vim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

" Plugins
" ------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Editing.
" ------------------------------------------------------------------------------
" Quotes, tags, parentheses
Plug 'tpope/vim-surround'

" Comments.
Plug 'tpope/vim-commentary'


" Movement
" ------------------------------------------------------------------------------
" Center text.
Plug 'junegunn/goyo.vim'

" Horizontal navigation.
Plug 'unblevable/quick-scope'

" Vertical navigarion.
Plug 'easymotion/vim-easymotion'

" Move selected text.
Plug 'matze/vim-move'
let g:move_key_modifier = 'C'


" Files
" ------------------------------------------------------------------------------
" Common Unix Commands.
Plug 'tpope/vim-eunuch'

" File explorer.
Plug 'preservim/nerdtree'
let NERDTreeShowHidden = 1

" Man pages (Do not surround with quotes!)
runtime ftplugin/man.vim


" Appearance
" ------------------------------------------------------------------------------
" Status line.
Plug 'itchyny/lightline.vim'

" Colorshemes.
Plug 'tomasr/molokai'
Plug 'gosukiwi/vim-atom-dark'
Plug 'drewtempelmeyer/palenight.vim'

call plug#end()
