scriptencoding utf-8

" File:     nerdtree.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

let g:NERDTreeWinSize = 30
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI  = 1  " Disable '?' help at the top
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeBookmarksFile = g:cache_dir . '/NERDTreeBookmarks'

let g:NERDTreeIgnore = [
\  'htmlcov',
\  '.git', '.idea',
\  '__pycache__', '.mypy_cache', '.pytest_cache'
\]

augroup vimrc_nerdtree
  autocmd!
  autocmd BufEnter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
augroup END

nnoremap <silent> <leader>f :NERDTreeToggle<CR>
