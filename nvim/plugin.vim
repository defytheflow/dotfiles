
" Filename:     plugin.vim
" Description:  Plugins

" Created:      29.03.2020
" Author:       Artyom Danilov


" Install {{{

" Vim-plug
if !filereadable($HOME . '/.config/nvim/autoload/plug.vim')

  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  autocmd VimEnter * PlugInstall | source $MYVIMRC

endif

let g:plugged_home = $HOME . '/.config/nvim/plugged/'

" Missing plugins.
for plugin in ['vim-surround', 'vim-commentary', 'vim-eunuch', 'goyo.vim',
\              'quick-scope', 'vim-easymotion', 'vim-move', 'nerdtree',
\              'vim-airline', 'molokai', 'vim-atom-dark', 'palenight.vim',
\              'vim-preview', 'auto-pairs', 'deoplete.nvim', 'deoplete-jedi',
\              'indentLine']

    if !isdirectory(g:plugged_home . plugin)
        autocmd VimEnter * PlugInstall | source $MYVIMRC
        break
    endif

endfor

"}}}


" Source {{{

call plug#begin(g:plugged_home)

" Python code folding
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview = 1  " Preview docstrings in folds
let g:SimpylFold_fold_import = 0        " Do not fold imports

" Syntax Checking
Plug 'vim-syntastic/syntastic'
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" Python autocompletion
Plug 'deoplete-plugins/deoplete-jedi'

" Indentation levels
Plug 'Yggdroot/indentLine'
let g:indentLine_char =  '¦'
let g:indentLine_leadingSpacChar='·'
let g:indentLine_leadingSpaceEnabled='1'

" Automatic quote and bracket completion
Plug 'jiangmiao/auto-pairs'

" Filetype icons
Plug 'ryanoasis/vim-devicons'

" Preview markup
Plug 'greyblake/vim-preview'

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
