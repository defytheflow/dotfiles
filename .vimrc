" Modified by Artyom Danilov on December 30, 2019.

"		   COLOR SCHEME

" For compatibility with tmux colors
set t_Co=256
set background=dark

"		     WHITE SPACE

" Automatically wrap text that extends beyond the screen length
set wrap
set textwidth=80

"		      OTHER

" Encoding
set encoding=utf-8

" Backup
set backup
set backupdir=~/.vimbackup

" Enable mouse for scrolling and resizing.
set mouse=a

" Increase the undo limit
set history=1000

"		   HIGHLIGHTING

" Enable spellchecking
" set spell

" Turn on syntax highlighting
syntax enable

" Show line numbers
set number

" Highlight current line
set cursorline

" Highlight matching [{()}]
set showmatch

" set list lcs=tab:>_ 

" 		CUSTOM KEY BINDINGS

" Move to beginning/end of line
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
command EditBashRc :edit ~/.bashrc
command EditBashLib :edit ~/.bash_lib
command EditBashAlias :edit ~/.bash_aliases
command EditTmux :edit ~/.tmux.conf

"		    INDENTATION

" Load file type-specific indent files
filetype indent plugin on

" Tab's size for different files
autocmd Filetype c  setlocal tabstop=8
autocmd Filetype cpp setlocal tabstop=8

autocmd Filetype asm setlocal tabstop=4
autocmd Filetype s setlocal tabstop=4

autocmd FileType sh setlocal tabstop=4

autocmd FileType txt setlocal tabstop=4
