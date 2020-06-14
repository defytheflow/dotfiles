
" File:     funcs.vim
" Created:  28.02.2020
" Author:   Artyom Danilov


fun! ColorColumnToggle()
    if &cc == ''
        set colorcolumn=+1  " Highlight column after 'textwidth'
    else
        set colorcolumn=
    endif
endfun

fun! CursorLineToggle()
    if &cul == 1
        set nocursorline
    else
        set cursorline
    endif
endfun

fun! CursorColumnToggle()
    if &cuc == 1
        set nocursorcolumn
    else
        set cursorcolumn
    endif
endfun

fun! HighlightSearchToggle()
    if &hlsearch == 1
        set nohlsearch
    else
        set hlsearch
    endif
endfun

fun! AutoCommentToggle()
    if matchstr(&formatoptions, 'cro') == 'cro'
        setlocal formatoptions-=cro
    else
        setlocal formatoptions+=cro
    endif
endfun
