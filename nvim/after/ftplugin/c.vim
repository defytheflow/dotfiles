
" File:     c.vim
" Created:  10.09.2020
" Author:   Artyom Danilov (@defytheflow)


fun! CAssembly()
  !gcc -S -masm=intel -fverbose-asm %
  let l:name = expand('%:r') . '.s'
  execute 'split ' . name
endfun

command! As call CAssembly()

nnoremap <leader>m :Man<CR>
