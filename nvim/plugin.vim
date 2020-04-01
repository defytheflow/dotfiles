"
" Filename:     plugin.vim
" Description:  Plugins
"
" Created:      29.03.2020
" Author:       Artyom Danilov
"


" Install {{{

" Vim-plug
if !filereadable($HOME . '/.config/nvim/autoload/plug.vim')

  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  autocmd VimEnter * PlugInstall | source $MYVIMRC

endif

" Missing plugins.
for plugin in ['vim-surround', 'vim-commentary', 'vim-eunuch', 'goyo.vim',
\              'quick-scope', 'vim-easymotion', 'vim-move', 'nerdtree',
\              'vim-airline', 'molokai', 'vim-atom-dark', 'palenight.vim']

    if !isdirectory($HOME . '/.config/nvim/plugged/' . plugin)
        autocmd VimEnter * PlugInstall | source $MYVIMRC
	break
    endif

endfor

"}}}


" Source {{{

call plug#begin('~/.config/nvim/plugged')

" Quotes, parentheses, tags.
Plug 'tpope/vim-surround'

" Comments.
Plug 'tpope/vim-commentary'

" Center text.
Plug 'junegunn/goyo.vim'

" Horizontal navigation.
Plug 'unblevable/quick-scope'

" Vertical navigarion.
Plug 'easymotion/vim-easymotion'

" Selected text movement.
Plug 'matze/vim-move'
let g:move_key_modifier = 'C'

" Common Unix Commands.
Plug 'tpope/vim-eunuch'

" File explorer.
Plug 'preservim/nerdtree'
let NERDTreeShowHidden = 1

" Status/tabline
Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1

" Colorshemes.
Plug 'tomasr/molokai'
Plug 'gosukiwi/vim-atom-dark'
Plug 'drewtempelmeyer/palenight.vim'

call plug#end()

" }}}


" Man pages (Do not surround with quotes!)
runtime ftplugin/man.vim
