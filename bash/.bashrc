#!/bin/bash

# File:     .bashrc
# Created:  30.12.2019
# Author:   Artyom Danilov (@defytheflow)

# If not running interactively, don't do anything.
case $- in
*i*) ;;

*)
  return
  ;;
esac

# History
# ------------------------------------------------------------------------------
export HISTCONTROL='ignoredups'
export HISTFILE="${XDG_CACHE_HOME}"/bash/history # <-- Store history in here
export HISTSIZE=10000
export HISTFILESIZE=10000

# Colorize prompt
# ------------------------------------------------------------------------------
case "${TERM}" in
xterm-color | *-256color)
  color_prompt='yes'
  ;;
esac

force_color_prompt='yes'

if [ -n "${force_color_prompt}" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt='yes'
  else
    color_prompt=''
  fi
fi

# Shell options
# ------------------------------------------------------------------------------
# Append to the history file, don't overwrite it.
shopt -s histappend

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Enable changing directories without typind 'cd'
shopt -s autocd

# Minor errors in the spelling of the directory will be corrected
shopt -s cdspell

# Enable spelling correction on directory names during word completion
shopt -s dirspell

# Enable matching files in a case-insensitive fashion when performing path
# name expansion
shopt -s nocaseglob

# For ctrl mappings in vim.
stty -ixon

# Config files
# ------------------------------------------------------------------------------
# Load aliases and functions, that can be used in any posix shell.
for file in "${DOTFILES_HOME}"/shell/*; do
  . "${file}"
done

# Prompt.
# ------------------------------------------------------------------------------
if [ "${color_prompt}" = 'yes' ]; then
  [ -f "${DOTFILES_HOME}"/bash/.bashprompt ] &&
    . "${DOTFILES_HOME}"/bash/.bashprompt
else
  PS1='\u@\h:\w\$ '
fi
