#!/bin/bash

#
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|
#

# Author: Artyom Danilov.
# Last modified on February 23, 2020.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return ;;
esac

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# INTERACTIVE OPTIONS

# Append to the history file, don't overwrite it
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

# For ctrl mappings
stty -ixon

# PROMPT.
if [ "$color_prompt" = yes ]; then
    if [[ -f $HOME/.bash_prompt ]]; then
        . "$HOME/.bash_prompt"
    fi
else
    PS1='\u@\h:\w\$ '
fi

# ALIASES.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# FUNCTIONS.
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# EXPORTS.
if [ -f ~/.bash_exports ]; then
    . ~/.bash_exports
fi

