" File:     quote.vim
" Author:   Artyom Danilov
" Modified: March 14, 2020

function! quote#UnquoteWord()

    let cword = expand('<cWORD>')

    if strpart(cword, 0, 1) == '"'
        exec "normal di\"hPl2x"
    elseif strpart(cword, 0, 1) == "'"
        exec "normal di\'hPl2x"
    endif

endfunction

function! quote#QuoteWord(quote)

    let cword = expand('<cWORD>')
    exec "normal ciw" . a:quote . "\<C-r>\"" . a:quote

endfunction
