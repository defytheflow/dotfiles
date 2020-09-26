
" File:     nerdtree.vim
" Created:  26.09.2020
" Author:   Artyom Danilov (@defytheflow)
" Info:     NERDTree configuration.


" variables.
let g:NERDTreeWinSize = 25
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI  = 1  " Disable '?' help at the top
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
let g:NERDTreeIgnore = [
\  'htmlcov',
\  '.git', '.idea',
\  '__pycache__', '.mypy_cache', '.pytest_cache'
\]

" autocmds.
augroup vimrc_nerdtree
  autocmd!
  autocmd BufEnter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
augroup END

" mappings.
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
