" File:      function.vim
" Purpose:   define custom vim functions
" Created:   28.02.2020
" Modified:  28.03.2020
" Author:    Artyom Danilov


function! ToggleColorColumn()
    " ColorColumn on/off.

    if &cc == ''
        " Highlight column after 'textwidth'
        set cc=+1
    else
        set cc=
    endif

endfunction


function! ToggleColorScheme()
    " Switch colorscheme.

    if g:colors_name == 'molokai'
        color atom-dark-256
    elseif g:colors_name == 'atom-dark-256'
        color palenight
    else
        color molokai
    endif

endfunction


function! ToggleNumber()
    " Number on/off.

    if &number || &relativenumber
        set nonumber
        set norelativenumber
    else
        set number
        set relativenumber
    endif

endfunction


function! ToggleRelativeNumber()
    " Relative number on/off.

    if &relativenumber
        set norelativenumber
    else
        set relativenumber
    endif

endfunction


function! TrimWhitespace()
    " Remove traling whitespace in the whole file.

    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)

endfun


function! GetCommentToken()
    " Return the comment token used in a prog language.

    let l:hash = ['php', 'ruby', 'sh', 'make', 'python', 'perl']
    let l:slashes = ['javascript', 'c', 'cpp', 'java', 'objc', 'scala', 'go']

    if index(hash, &filetype) >= 0
        return '#'
    elseif index(slashes, &filetype) >= 0
        return '//'
    elseif &filetype == 'vim'
        return '"'
    else
        return '#'
    endif

endfunction


function! WriteVisualComment()

    let l:token  = GetCommentToken() " (e.g. #, //)
    let l:char = '-'
    let l:format = token . ' %s'
    let l:space  = 1                 " space character

    let l:text = input('Text: ')  " comment text
    " If no input text:
    if len(text) == 0
        echom 'Error: no input text.'
        return
    endif

    " Get the number of char to add on left and right
    let l:length = &textwidth - len(text) - len(format)
    let l:left   = length / 2
    let l:right  = length - left

    " Insert in the buffer
    put = printf(format, repeat(char, &textwidth - len(token) * 2))
    put = printf(format, repeat(' ', left) . text)
    put = printf(format, repeat(char, &textwidth - len(token) * 2))

endfunction
