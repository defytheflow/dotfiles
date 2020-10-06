scriptencoding utf-8

" File:     autocmds.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

augroup vimrc_rainbow
  au!
  au FileType c,cpp,java,typescript :RainbowLoad
augroup END

augroup vimrc_syntax
  au!
  au BufNewFile,BufRead setup.cfg           setlocal ft=toml
  au BufNewFile,BufRead .prettierrc         setlocal ft=json
  au BufNewFile,BufRead ~/.config/i3/config setlocal ft=i3config
augroup END

augroup vimrc_whitespace
  au!
  au BufWritePre * %s/\s\+$//e
  au BufWritePre * %s/\n\+\%$//e
augroup END

augroup vimrc_indent
  au!
  au FileType sh,zsh,vim,css,html,json,gitconfig setlocal shiftwidth=2 softtabstop=2
augroup END

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
  au!
  au BufReadPost * call JumpToLastPos()
  au FileType    * set formatoptions-=cro " disable auto-commenting.
  au VimEnter    * :NoMatchParen
  au SourcePost   $MYVIMRC call InstallPlugins()
augroup END
