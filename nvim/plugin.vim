
" Filename:     plugin.vim
" Description:  Pluggins download and settings.

" Created:      29.03.2020
" Author:       Artyom Danilov

" Download vim-plug {{{
if !filereadable($HOME . '/.config/nvim/autoload/plug.vim')
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
"}}}

" Download pluggins {{{
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

Plug 'airblade/vim-gitgutter'  " Show git difference in the number column.
Plug 'tpope/vim-fugitive'      " Git commands.
Plug 'ctrlpvim/ctrlp.vim'      " Fuzzy find files.
Plug 'jiangmiao/auto-pairs'    " Auto-completion of quotes and brackets.
Plug 'alvan/vim-closetag'      " Auto-completion of html tags.
Plug 'tpope/vim-surround'      " Editing quotes, parentheses, tags.
Plug 'tpope/vim-commentary'    " Commenting.
Plug 'unblevable/quick-scope'  " Horizontal navigation.

" Text object replacement.
Plug 'inkarkat/vim-ReplaceWithRegister'

" Python syntax higlight.
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" Syntastic {{{
Plug 'vim-syntastic/syntastic'

" Load errors into the location list to jump between them.
let g:syntastic_always_populate_loc_list = 1
" Check for errors when file is opened.
let g:syntastic_check_on_open = 0
" Check for errors when file is saved.
let g:syntastic_check_on_wq = 1
" Indicate a line with error.
let g:syntastic_error_symbol = "✗"

" Check python3 syntax.
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python']
"}}}

" Deoplete {{{
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" Python.
Plug 'deoplete-plugins/deoplete-jedi'
"}}}

" Java-complete {{{
Plug 'artur-shaik/vim-javacomplete2' " Java autocomletion
autocmd FileType java setlocal omnifunc=javacomplete#Complete
let g:JavaComplete_ClosingBrace = 0
"}}}

" Better-whitespace {{{
Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
"}}}

" Indent-line  {{{
Plug 'Yggdroot/indentLine'

let g:indentLine_char =  '¦'
let g:indentLine_leadingSpacChar='·'
let g:indentLine_leadingSpaceEnabled='1'
"}}}

" Nerdtree {{{
Plug 'preservim/nerdtree'

" Show hidden files.
let NERDTreeShowHidden = 1
" Disable '?' help at the top
let NERDTreeMinimalUI  = 1
" Automatically delete the buffer of the file you just deleted.
let NERDTreeAutoDeleteBuffer = 1
" Don't show these entries.
let NERDTreeIgnore=['__pycache__', '.git', '\.o$', '\.class$']

" Tab settings for nerdtree.
Plug 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_console_startup = 2

" Icon settings for nerdtree.
Plug 'ryanoasis/vim-devicons'
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
"}}}

" Airline {{{
Plug 'vim-airline/vim-airline'

" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1
" Display hunks if the diff is non-zero.
let g:airline#extensions#hunks#non_zero_only = 1
"}}}

" Limelight {{{
Plug 'junegunn/limelight.vim'

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
"}}}

" Goyo {{{
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

" Colors {{{
Plug 'tomasr/molokai'
Plug 'gosukiwi/vim-atom-dark'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'dracula/vim'
Plug 'AlessandroYorba/Alduin'
let g:alduin_Shout_Become_Ethereal = 1
let g:alduin_Shout_Fire_Breath = 1
"}}}

call plug#end()

" Man pages (Do not surround with quotes!)
runtime ftplugin/man.vim
