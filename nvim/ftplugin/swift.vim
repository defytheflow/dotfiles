scriptencoding utf-8

" File:     swift.vim
" Created:  28.03.2023
" Author:   Artyom Danilov (@defytheflow)

try
  colorscheme xcodedarkhc
  lua require('lualine').setup()
catch
endtry

setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4

setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal nofoldenable

setlocal makeprg=swift\ %

" make term
nnoremap <leader>mt :w \| :term swift %<CR>
" make split
nnoremap <leader>ms :w \| :sp \| :term swift %<CR>
