" Modified by Artyom Danilov on Januuary 9, 2020.

"                       COLORS

" For compatibility with tmux colors
set t_Co=256
set background=dark

" Color Scheme
colorscheme koehler

"                    WHITE SPACE

" Automatically wrap text that extends beyond the screen length
set wrap
set textwidth=80

"                       OTHER

" To enable all vim features
set nocompatible

" Encoding
set encoding=utf-8

" Backup
set backup
set backupdir=~/.vimbackup

" Enable mouse for scrolling and resizing.
set mouse=a

" Increase the undo limit
set history=1000

"                      HIGHLIGHTING

" Turn on syntax highlighting
syntax enable

" Show line numbers
set number

" Highlight current line
set cursorline

" Highlight matching [{()}]
set showmatch

" Display these special characters
" set listchars=tab:>·,trail:~
set listchars=trail:~

" Highlight the X column
set colorcolumn=81

" Press F7 to activate spell checking, F8 to turn it off.
map <F7> <Esc>:setlocal spell spelllang=en_us<CR>
map <F8> <Esc>:setlocal nospell<CR>

"             CUSTOM KEY BINDINGS

" Move to beginning/end of line
nnoremap B ^
nnoremap E $

" Move ctrl + hjkl in Insert Mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Move ctrl + hjkl in Command Mode
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

" Remove arrows in Normal Mode
nnoremap <Left>  :echo "Type 'h', moron!" <CR>
nnoremap <Right> :echo "Type 'l', prat!"  <CR>
nnoremap <Up>    :echo "Type 'k', git!"   <CR>
nnoremap <Down>  :echo "Type 'j', fool!"  <CR>

" Remove arrow keys in Insert Mode
inoremap <Left>  <Esc>
inoremap <Right> <Esc>
inoremap <Up>    <Esc>
inoremap <Down>  <Esc>

" Remove arrows in Visual Mode
vnoremap <Left>  :echo "Type 'h', moron!" <CR>
vnoremap <Right> :echo "Type 'l', prat!"  <CR>
vnoremap <Up>    :echo "Type 'k', git!"   <CR>
vnoremap <Down>  :echo "Type 'j', fool!"  <CR>

"               CUSTOM COMMANDS

command EditVim  :edit ~/.vimrc
command EditBashRc :edit ~/.bashrc
command EditBashLib :edit ~/.bash_lib
command EditBashAlias :edit ~/.bash_aliases
command EditTmux :edit ~/.tmux.conf

"                 INDENTATION

" Supposed to do something good
set autoindent
set smartindent

" Some indentation for C programs
set cindent

" Load file type-specific indent files
filetype indent plugin on

" Tab's size for different files
autocmd Filetype c  setlocal tabstop=8
autocmd Filetype cpp setlocal tabstop=8

autocmd Filetype asm setlocal tabstop=4
autocmd Filetype s setlocal tabstop=4

autocmd FileType sh setlocal tabstop=4

autocmd FileType txt setlocal tabstop=4
