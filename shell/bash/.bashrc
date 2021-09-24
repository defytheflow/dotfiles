#!/bin/bash

# File:     .bashrc
# Created:  30.12.2019
# Author:   Artyom Danilov (@defytheflow)

[[ -f "${HOME}/.profile" ]] && source "${HOME}/.profile"

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
export HISTFILE="${XDG_CACHE_HOME}/bash/history"
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

# options.
set -o vi # Enable vi mode.

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

# prompt.
if [ "${color_prompt}" = 'yes' ]; then
  PROMPT_COMMAND=my_prompt
else
  PS1='\u@\h:\w\$ '
fi

function my_prompt() {
  green=`tput setaf 82`
  lime_green=`tput setaf 154`
  orange=`tput setaf 202`
  purple=`tput setaf 135`
  red=`tput setaf 160`
  white=`tput setaf 15`
  reset=`tput sgr0`

  if [ $? -eq 0 ]; then
    exit_status=" ${green}:)"
  else
    exit_status=" ${red}:("
  fi

  if [ `whoami` = 'root' ]; then
    PS1="\n${red}\u"
    PS1+="${white} at ${red}\h"
    PS1+="${white} in ${red}\w"
  else
    PS1="\n${purple}\u"
    PS1+="${white} at ${orange}\h"
    PS1+="${white} in ${lime_green}\w"
  fi
  PS1+="${exit_status}${reset}\n\$ "
}

# other.
if [[ -n "${DOTFILES_HOME}" ]]; then
  for entry in "${DOTFILES_HOME}"/shell/*;do
    [[ -f ${entry} ]] && source "${entry}"
  done
fi
