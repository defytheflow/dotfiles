" Modified by Artyom Danilov on January 26, 2020.

" 1. INDENTATION (!)
"
" - Each tab is expanded into spaces, amount of spaces depends on the FileType. 
"   Default is 4.
"

" In Insert mode uses the approptiate number of spaces to insert a <Tab>. 
set expandtab

" Number of spaces that a <Tab> counts for while performing editing
" operations.
set softtabstop=4

" Does smart autoindenting when starting a new-line. Looks at the current line
" for braces and previous indentation level.
set smartindent

" Controls how many columns text is indented with the reindent operations
" (<< and >>) and automatic C-style indentation.
set shiftwidth=4

" Indentation for C/C++ source
autocmd Filetype    c setlocal shiftwidth=8 softtabstop=8
autocmd Filetype  cpp setlocal shiftwidth=4 softtabstop=4

" Indentation for Assembly source
autocmd Filetype  asm setlocal shiftwidth=4 softtabstop=4
autocmd Filetype    s setlocal shiftwidth=4 softtabstop=4

" Indentation for HTML source
autocmd FileType html setlocal shiftwidth=2 softtabstop=2

" 2. HIGHLIGHTING (!)
"
" - Syntax, Line numbers, Cursor line, Matching brackets, 
"
"

" Switches on syntax highlighting.
syntax enable

" Precedes each line with its line number.
set number

" Highlights the current line of the cursor.
set cursorline

" When a bracket is inserted, briefly jumps to the matching one.
set showmatch

" A list of string settings.
set list listchars=tab:>-,trail:-

" Highlight the X column
set colorcolumn=81

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
set backupdir=~/.backup/vim

" Enable mouse for scrolling and resizing.
set mouse=a

" Increase the undo limit
set history=1000

" Press F7 to activate spell checking, F8 to turn it off.
map <F7> <Esc>:setlocal spell spelllang=en_us<CR>
map <F8> <Esc>:setlocal nospell<CR>

"             CUSTOM KEY BINDINGS

" Remove arrows in Normal Mode
nnoremap <Left>  :echo "Type 'h', moron!" <CR>
nnoremap <Right> :echo "Type 'l', prat!"  <CR>
nnoremap <Up>    :echo "Type 'k', git!"   <CR>
nnoremap <Down>  :echo "Type 'j', fool!"  <CR>

" Remove arrow keys in Insert Mode
" inoremap <Left>  <Esc>
" inoremap <Right> <Esc>
" inoremap <Up>    <Esc>
" inoremap <Down>  <Esc>

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

