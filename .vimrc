" Modified by Artyom Danilov on December 27th, 2019.

"		   COLOR SCHEME

" For compatibility with tmux colors
set t_Co=256
set background=dark

"		     WHITESPACE

" Automatically wrap text that extends beyond the screen length
set wrap

set textwidth=80

"		      OTHER

" Encoding
set encoding=utf-8

set backup
set backupdir=~/.vimbackup

"		   HIGHLIGHTING

" Turn on syntax highlighting
syntax enable

" Show line numbers
set number

" Highlight current line
set cursorline

" Highlighti matchin [{()}]
set showmatch

" 		CUSTOM KEY BINDINGS

" Move to beggining/end of line
nnoremap B ^
nnoremap E $

"		DISABLED KEYS

" Remove arrows in Normal Mode
nnoremap <Left>  :echo "Type 'h', moron!" <CR>
nnoremap <Right> :echo "Type 'l', prat!"  <CR>
nnoremap <Up>    :echo "Type 'k', git!"   <CR>
nnoremap <Down>  :echo "Type 'j', fool!"  <CR>

" Remove arrows in Visual Mode
vnoremap <Left>  :echo "Type 'h', moron!" <CR>
vnoremap <Right> :echo "Type 'l', prat!"  <CR>
vnoremap <Up>    :echo "Type 'k', git!"   <CR>
vnoremap <Down>  :echo "Type 'j', fool!"  <CR>

"		CUSTOM COMMANDS

command EditVim  :edit ~/.vimrc
command EditBash :edit ~/.bashrc
command EditTmux :edit ~/.tmux.conf

"		    INDENTATION

" Load filetype-specific indent files
filetype indent on

autocmd Filetype py setlocal tabstop=4
autocmd Filetype c  setlocal tabstop=8
autocmd FIletype asm setlocal tabstop=4
autocmd FIletype s setlocal tabstop=4

" Tabs are spaces
"set expandtab

" Number of visual spaces per TAB
" set tabstop=4

" Number of spaces in tab when editing
" set softtabstop=4
