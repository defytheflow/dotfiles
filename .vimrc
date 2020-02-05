" Author: Artyom Danilov
" Last Modification: January 27, 2020.

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

" Lines longer than the width of the window wrap and displaying continues
" on the next line.
set wrap

" Maximum width of the text that is being inserted.
set textwidth=80
set formatoptions+=t

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
" - Syntax, Line numbers, Matching brackets, Tabs, Trailing spaces,
"   81st column.
"

" Compatibility with tmux colors
set t_Co=256
set background=dark

" Colorschemes
colorscheme koehler
"colorscheme murphy
"colorscheme zellner

" Switches on syntax highlighting.
syntax enable

" Precedes each line with its line number.
set number relativenumber

" When a bracket is inserted, briefly jumps to the matching one.
set showmatch

" A list of characters to show instead of tabs and trailing spaces.
set list listchars=tab:>-,trail:-

" Highlight the 81st column with magenta
set colorcolumn=81
highlight ColorColumn ctermbg=5

" 3. SPLIT (!)

" Overrides vim default splitting settings
set splitbelow splitright

" Shortcuts for split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" 4. BACKUP (!)

set backup
if !isdirectory($HOME . "/.backup/vim")
    call mkdir($HOME . "/.backup/vim", "p", 0700)
endif
set backupdir=~/.backup/vim

" 5. ARROWS (!)

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

" 6. CUSTOM COMMANDS (!)

command EditVim          :edit ~/.vimrc
command EditTmux         :edit ~/.tmux.conf
command EditBashRc       :edit ~/.bashrc
command EditBashLib      :edit ~/.bash_lib
command EditBashAlias    :edit ~/.bash_aliases
command EditBashFunction :edit ~/.bash_functions

" 7. OTHER (!)

" To enable all vim features
set nocompatible

" Enable mouse for scrolling and resizing.
set mouse=a

" Increase the undo limit
set history=1000

