
" Filename:     function.vim
" Description:  Custom commands

" Created:      28.02.2020
" Author:       Artyom Danilov


fun! ColorColumnToggle()
    " ColorColumn on/off. "
    if &cc == ''
        " Highlight column after 'textwidth'
        set colorcolumn=+1
    else
        set colorcolumn=
    endif
endfun

fun! CursorLineToggle()
    " CursorLine on/off
    if &cul == 1
        set nocursorline
    else
        set cursorline
    endif
endfun

fun! CursorColumnToggle()
    " CursorColumn on/off
    if &cuc == 1
        set nocursorcolumn
    else
        set cursorcolumn
    endif
endfun

fun! ColorSchemeSave()
    " Permanently save current color scheme.
    let l:tag = '<-ColoSave->'
    execute '!sed -i -E "s/colo .+ ' . l:tag . '/colo ' . g:colors_name . '  \" ' . l:tag . '/g" ' . $DOTFILES_HOME . '/nvim/init.vim'
endfun

fun! ColorSchemeSwitch()
    " Switch colorscheme. "
    let l:colors = ['molokai', 'atom-dark-256', 'palenight', 'alduin', 'dracula']

    let l:i = 0
    while i < len(colors)
        if colors[i] == g:colors_name
            if i < len(colors) - 1
                execute ':colo ' . l:colors[i+1]
            else
                execute ':colo ' . l:colors[0]
            endif
            break
        endif
        let l:i += 1
    endwhile
endfun

fun! GetCommentToken()
    " Return the comment token used in a prog language. "
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
endfun

fun! VisualComment()
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
endfun
