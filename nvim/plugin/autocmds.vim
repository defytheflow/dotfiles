scriptencoding utf-8

" File:     autocmds.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

augroup vimrc_syntax
  au!
  au BufNewFile,BufRead setup.cfg             setlocal filetype=toml
  au BufNewFile,BufRead .prettierrc,.eslintrc setlocal filetype=json
  au BufNewFile,BufRead ~/.config/i3/config   setlocal filetype=i3config
  au BufNewFile,BufRead coc-settings.json     setlocal filetype=jsonc
  au BufNewFile,BufRead tsconfig.json         setlocal filetype=jsonc
  " vscode configuration files.
  au BufNewFile,BufRead settings.json         setlocal filetype=jsonc
  au BufNewFile,BufRead keybindings.json      setlocal filetype=jsonc
  au BufNewFile,BufRead *code-snippets        setlocal filetype=jsonc
augroup END

augroup vimrc_whitespace
  au!
  au BufWritePre * %s/\s\+$//e
  au BufWritePre * %s/\n\+\%$//e
augroup END

augroup vimrc_indent
  au!
  au FileType ocaml,lua,*sh,vim,*css,html*,git*,toml,sql,prisma setlocal shiftwidth=2 softtabstop=2
  au FileType vimwiki runtime ftplugin/text.vim
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

augroup vimrc_binary
  au!
  au BufReadPre  *.bin let &bin = 1

  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set filetype=xxd | endif

  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif

  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END
