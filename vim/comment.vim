" File:     comment.vim
" Author:   Artyom Danilov
" Modified: March 14, 2020

" Return the token used for commenting in a programming language.
function! comment#GetToken()

    let ft = &filetype

    if ft == 'php' || ft == 'ruby' || ft == 'sh' || ft == 'make'
       \ || ft == 'python' || ft == 'perl'
        return '#'
    elseif ft == 'javascript' || ft == 'c' || ft == 'cpp' || ft == 'java'
        \ || ft == 'objc' || ft == 'scala' || ft == 'go'
        return '//'
    elseif ft == 'vim'
        return '"'
    endif

endfunction

function! comment#CommentLine(token)

    if a:token == '#'
        silent! s/^/\#/
    elseif a:token == '//'
        silent! s:^:\/\/:g
    elseif a:token == '"'
        silent! s:^:\":g
    endif

endfunction

function! comment#UncommentLine(token)

    if a:token == '#'
        silent! s/^\#//
    elseif a:token == '//'
        silent! s:^\/\/::g
    elseif a:token == '"'
        silent! s:^\"::g
    endif

endfunction

function! comment#ToggleLine()

    let token = comment#GetToken()

    if strpart(getline('.'), 0, 1) == token
        call comment#UncommentLine(token)
    else
        call comment#CommentLine(token)
    endif

endfunction

" Visual Comment.
function! comment#VisualLine()

    let token  = comment#GetToken()
    let text   = input("Text: ")
    let format = token . ' %s ' . token
    let wrap   = 80

    if len(text) == 0
        return

    " Get the number of char to add on left and right
    let length   = (wrap - len(text) - len(printf(format, '')))
    let left  = length / 2
    let right = length - left

    " Insert in the buffer
    put = printf(format, repeat('-', wrap - 4))
    put = printf(format, repeat(' ', left) . text . repeat(' ',  right))
    put = printf(format, repeat('-', wrap - 4))

endfunction
