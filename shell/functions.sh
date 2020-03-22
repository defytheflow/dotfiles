#!/usr/bin/zsh

# ---------------------------------------------------------------------------- 
# | File:      functions.sh
# ---------------------------------------------------------------------------- 
# | Modified:  March 20, 2020
# ---------------------------------------------------------------------------- 
# | Author:    Artyom Danilov
# ---------------------------------------------------------------------------- 

echo "Running ${0}"

# Export following variables and functions.
set -a

# Cd into directory and ls it automatically.
cd() {
        builtin cd $1 && ls || return
}

# Sources .bashrc or .zshrc according to current shell.
rld() {
    if [ -n "${BASH_VERSION}" ]; then
        . "${HOME}/.bashrc"
    elif [ -n "${ZSH_VERSION}" ]; then
        . "${HOME}/.zshrc"
    fi
}

# Print first passed argument to the center of the terminal.
echoc() {
    local text=$1
    local width=$(stty size | cut -d ' ' -f2)
    local length=${#text}
    printf "%$(( length + (width - length) / 2 ))b\n" "${text}"
}

# Print all passed arguments to stderr.
err() {
    echo "$*" >&2
}

# Return 0 if $1 (directory) is empty.
isempty() {
    local dir=$1
    return $([[ "$(find "${dir}" -type f | wc -l)" -eq 0 ]])
}

# Create a $1 (directory) and cd into it.
mkcd() {
    local dir=$1
    mkdir -p "${dir}" && cd "${dir}" || return
}

# Set all passed arguments as terminal title.
termtitle() {
    echo -ne "\033]0;$*\007"
}

# Return number of files in $1 (directory).
filenum()
{
    local dir=$1
    if [[ $# -gt 0 ]]; then
        find "${dir}" -maxdepth 1 -type f | wc -l
    else
        find "."      -maxdepth 1 -type f | wc -l
    fi
}

# Return number of directories in $1 (directory).
dirnum()
{
    local dir=$1
    if [[ $# -gt 0 ]]; then
        find "${dir}" -maxdepth 1 -type d | wc -l
    else
        find "."      -maxdepth 1 -type d | wc -l
    fi
}

# Don't export following variables and functions.
set +a
