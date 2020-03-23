#!/usr/bin/sh

# ------------------------------------------------------------------------------
# | File:      functions.sh
# ------------------------------------------------------------------------------
# | Modified:  March 23, 2020
# ------------------------------------------------------------------------------
# | Author:    Artyom Danilov
# ------------------------------------------------------------------------------

echo "Running ${0}"

# Export following variables and functions.
set -a

# cd into directory and ls it automatically.
cdls() {
        cd "${1}" && ls || return
}

# Sources .bashrc or .zshrc according to current shell.
rld() {
    [ -n "${BASH_VERSION}" ] && exec bash && return
    [ -n "${ZSH_VERSION}" ]  && exec zsh  && return
}

# Print first passed argument to the center of the terminal.
echoc() {
    width=$(stty size | cut -d ' ' -f2)
    length=${#1}
    printf "%$(( length + (width - length) / 2 ))b\n" "${1}"
}

# Print all passed arguments to stderr.
err() {
    echo "$*" >&2
}

# Return 0 if $1 (directory) is empty.
isempty() {
    return "$([ "$(find "${1}" -type f | wc -l)" -eq 0 ])"
}

# Create a $1 (directory) and cd into it.
mkcd() {
    mkdir -p "${1}" && cd "${1}" || return
}

# Set all passed arguments as terminal title.
title() {
    printf "\033]0;%s\007" "$*"
}

# Return number of files in $1 (directory).
fn() {
    if [ $# -gt 0 ]; then
        find "${1}" -maxdepth 1 -type f | wc -l
    else
        find "."    -maxdepth 1 -type f | wc -l
    fi
}

# Return number of directories in $1 (directory).
dn() {
    if [ $# -gt 0 ]; then
        find "${1}" -maxdepth 1 -type d | wc -l
    else
        find "."    -maxdepth 1 -type d | wc -l
    fi
}

# Don't export following variables and functions.
set +a
