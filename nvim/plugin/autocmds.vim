scriptencoding utf-8

" File:     autocmds.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

fun! InstallPlugins()
  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    PlugInstall --sync | q
  endif
endfun

fun! JumpToLastPos()
  if line("'\"") > 1 && line("'\"") <= line('$')
    exe "normal! g'\""
  endif
endfun

augroup vimrc_misc
  autocmd!
  autocmd BufReadPost * call JumpToLastPos()
  autocmd FileType    * set formatoptions-=cro " disable auto-commenting.
  autocmd VimEnter    * :NoMatchParen
  autocmd SourcePost   $MYVIMRC call InstallPlugins()
  autocmd BufWritePost $MYVIMRC source $MYVIMRC " auto reload init.vim on save.
augroup END
