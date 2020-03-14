" File:     comment.vim
" Author:   Artyom Danilov
" Modified: March 14, 2020

" Return the token used for commenting in a programming language.
function! GetCommentToken(filetype)

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

" Comment line.
function! Comment(comment_token)

    if comment_token == '#'
        silent! s/^/\#/
    elseif comment_token == '//'
        silent! s:^:\/\/:g
    elseif comment_token == '"'
        silent! s:^:\":g
    endif

endfunction

" Uncomment line.
function! Uncomment(comment_token)

    if comment_token == '#'
        silent! s/^\#//
    elseif comment_token == '//'
        silent! s:^\/\/::g
    elseif comment_token == '"'
        silent! s:^\"::g
    endif

endfunction

" Toggle Comment or Uncomment.
function! CommentUncomment()

    let comment_token = GetCommentToken(&filetype)

    if strpart(getline('.'), 0, 1) == comment_token
        call Uncomment()
    else
        call Comment()
    endif

endfunction

" Visual Comment.
function! VisualComment()

    let comment_token = GetCommentToken(&filetype)
    let comment_format = comment_token . ' %s ' . comment_token
    let comment_char = '-'
    let comment_text = input("Text: ")

    " Get the number of char to add on left
    let len   = (80 - len(comment_text) - len(printf(comment_format, '')))
    let left  = len / 2
    let right = len - left

    " Insert in the buffer
    put=printf(comment_format, repeat(comment_char, 76))
    put=printf(comment_format, repeat(' ', left) . comment_text . repeat(' ',  right))
    put=printf(comment_format, repeat(comment_char, 76))

endfunction
