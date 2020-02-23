#!/bin/bash

# Author: Artyom Danilov
# Last modified on February 23, 2020.

# Prints the text to the center of the terminal.
echoc()
{
    width=$(stty size | cut -d" " -f2)
    length=${#1}
    printf "%$(( length + (width - length) / 2 ))s\n" "$1"
}
export -f echoc

# Prints to the 'stderr'.
echoerr() { printf "%s\n" "$*" 1>&2; }
export -f echoerr

# Returns 0 if $1 is a positive integer.
isuint() { return $([[ "$1" =~ ^[0-9]+$ ]]); }
export -f isuint

# Returns 0 if directory is empty.
isempty() { return $([[ "$(find "$1" -type f | wc -l)" -eq 0 ]]); }
export -f isempty

# Make a directory and cd into it.
mkcd() { mkdir -p "$1" && cd "$1" || return; }
export -f mkcd

# cd into directory and list it.
cl() { cd "$1" && ls; }
export -f cl

# Sets terminal title.
termtitle() { echo -ne "\033]0;$*\007"; }
export -f termtitle

# Returns number of files in directory.
filenum()
{
    if [[ $# -gt 0 ]]; then
        find "$1" -maxdepth 1 -type f | wc -l
    else
        find "."  -maxdepth 1 -type f | wc -l
    fi
}
export -f filenum

# Returns number of files in directory.
dirnum()
{
    if [[ $# -gt 0 ]]; then
        find "$1" -maxdepth 1 -type d | wc -l
    else
        find "."  -maxdepth 1 -type d | wc -l
    fi
}
export -f dirnum
