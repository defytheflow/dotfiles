
" Filename:     plugin.vim
" Description:  Pluggins download and settings.

" Created:      29.03.2020
" Author:       Artyom Danilov

" download vim-plug {{{
if !filereadable($HOME . '/.config/nvim/autoload/plug.vim')
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
"}}}

" download pluggins {{{
let g:plugged_home = $HOME . '/.config/nvim/plugged/'
for plugin in ['vim-surround', 'vim-commentary', 'goyo.vim', 'quick-scope',
\              'indentLine', 'vim-gitgutter', 'vim-better-whitespace',
\              'auto-pairs', 'vim-closetag',
\              'nerdtree', 'vim-nerdtree-tabs', 'vim-devicons', 'ctrlp.vim',
\              'vim-airline', 'molokai', 'vim-atom-dark', 'palenight.vim']
    if !isdirectory(g:plugged_home . plugin)
        autocmd VimEnter * PlugInstall | source $MYVIMRC
        break
    endif
endfor
"}}}

call plug#begin(g:plugged_home)

Plug 'junegunn/goyo.vim'       " Center text.
Plug 'ctrlpvim/ctrlp.vim'      " Fuzzy find files.
Plug 'airblade/vim-gitgutter'  " Show git difference in the number column.
Plug 'tpope/vim-fugitive'      " Git commands.
Plug 'jiangmiao/auto-pairs'    " Auto-completion of quotes and brackets.
Plug 'alvan/vim-closetag'      " Auto-completion of html tags.
Plug 'tpope/vim-surround'      " Editing quotes, parentheses, tags.
Plug 'tpope/vim-commentary'    " Commenting.
Plug 'unblevable/quick-scope'  " Horizontal navigation.
Plug 'inkarkat/vim-ReplaceWithRegister' " Replacing text.

" deoplete {{{
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
"}}}

" better-whitespace {{{
Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
"}}}

" indent-line  {{{
Plug 'Yggdroot/indentLine'
let g:indentLine_char =  '¦'
let g:indentLine_leadingSpacChar='·'
let g:indentLine_leadingSpaceEnabled='1'
"}}}

" nerd-tree {{{
Plug 'preservim/nerdtree'

" Show hidden files.
let NERDTreeShowHidden = 1
" Disable '?' help at the top
let NERDTreeMinimalUI  = 1
" Automatically delete the buffer of the file you just deleted.
let NERDTreeAutoDeleteBuffer = 1
" Don't show these entries.
let NERDTreeIgnore=['__pycache__']

" Tab settings for nerdtree.
Plug 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_console_startup = 1

" Icon settings for nerdtree.
Plug 'ryanoasis/vim-devicons'
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
"}}}

" air-line {{{
Plug 'vim-airline/vim-airline'
" Show PASTE in paste mode
let g:airline_detect_paste=1
" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1
" Display hunks if the diff is non-zer0
let g:airline#extensions#hunks#non_zero_only = 1
"}}}

" color-schemes {{{
Plug 'tomasr/molokai'
Plug 'gosukiwi/vim-atom-dark'
Plug 'drewtempelmeyer/palenight.vim'
"}}}

call plug#end()

" Man pages (Do not surround with quotes!)
runtime ftplugin/man.vim
