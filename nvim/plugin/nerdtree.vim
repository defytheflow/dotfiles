scriptencoding utf-8

" File:     nerdtree.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeBookmarksFile = g:cache_dir . '/NERDTreeBookmarks'
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeMinimalUI  = 1
" let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeWinSize = 60
let g:NERDTreeHijackNetrw = 0

let g:NERDTreeGitStatusIndicatorMapCustom = {
\ 'Modified'  :'✹ ',
\ 'Staged'    :'✚ ',
\ 'Untracked' :'✭ ',
\ 'Renamed'   :'➜ ',
\ 'Unmerged'  :'═ ',
\ 'Deleted'   :'✖ ',
\ 'Dirty'     :'✗ ',
\ 'Ignored'   :'☒ ',
\ 'Clean'     :'✔︎ ',
\ 'Unknown'   :'? ',
\ }

augroup vimrc_nerdtree
  au!
  au BufEnter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
augroup END

nnoremap <silent> <C-n> :NERDTreeToggle<CR>
