
" File:     maps.vim
" Created:  28.03.2020
" Author:   Artyom Danilov


" plugins
nnoremap <silent><leader>g :Goyo<CR>
nnoremap <silent><leader>n :NERDTreeTabsToggle<CR>
nnoremap <silent><leader>l :Limelight!!<CR>
nnoremap <silent><leader>a :A<CR>

" mine
nnoremap <silent><leader>h  :call HighlightSearchToggle()<CR>
nnoremap <silent><leader>x  :call AutoCommentToggle()<CR>
nnoremap <silent><leader>cc :call ColorColumnToggle()<CR>
nnoremap <silent><leader>cl :call CursorLineToggle()<CR>
nnoremap <silent><leader>ck :call CursorColumnToggle()<CR>

" miscellaneous
nnoremap <Space> za
nnoremap S :%s//g<Left><Left>
nnoremap Y y$

" vim
nnoremap <silent><leader>ev :split $MYVIMRC<CR>
nnoremap <silent><leader>sv :source $MYVIMRC<CR>

" buffers
command! BufOnly execute '%bdelete|edit #|normal `"'
nnoremap <silent><leader>b :BufOnly<CR>
nnoremap <tab>   :bnext<cr>
nnoremap <S-tab> :bprev<cr>

" shift
vnoremap < <gv
vnoremap > >gv
