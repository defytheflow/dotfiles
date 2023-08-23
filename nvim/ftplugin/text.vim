scriptencoding utf-8

" File:     text.vim
" Created:  04.10.2020
" Author:   Artyom Danilov (@defytheflow)

setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

setlocal wrap
setlocal linebreak " break line at words.

setlocal spell spelllang=en_us
setlocal thesaurus+=~/.config/nvim/thesaurus/mthesaur.txt
setlocal complete+=s " search thesaurus for autocomplete.

" augroup vimrc_text
"   au!
"   au ColorScheme * highlight SpellBad guifg=#ff0000 ctermfg=Red
" augroup END

" highlight SpellBad guifg=#ff0000 ctermfg=Red
