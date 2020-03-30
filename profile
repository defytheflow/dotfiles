#!/bin/sh

# File:      .profile
# Purpose:   Define essential environment variables.
# Created:   28.03.2020
# Modified:  28.03.2020
# Author:    Artyom Danilov


# XDG Base Directory
export XDG_CACHE_HOME="${HOME}"/.cache
export XDG_CONFIG_HOME="${HOME}"/.config
export XDG_DATA_HOME="${HOME}"/.local/share

# Dotfiles
export DOTFILES_HOME="${HOME}"/.dotfiles

# Zsh plugins
export ZPLUG_HOME="${XDG_CONFIG_HOME}"/zplug
export ZPLUG_CACHE_DIR="${XDG_CACHE_HOME}"/zplug

# System editor
export EDITOR='vim'

# Extend path
export PATH="${PATH}":"${HOME}"/.local/bin

# Bash
export BASHRC="${HOME}"/.bashrc  # config file

# C
export CFLAGS='-W -Wall -Wextra'  # compilation flags
export CPATH=''                   # include headers
export LD_LIBRARY_PATH=''         # link libraries

# i3
export I3CONF="${XDG_CONFIG_HOME}"/i3/config  # config file

# ?
export ICEAUTHORITY="${XDG_CACHE_HOME}"/ICEauthority

# git
export MYGITHUB='https://github.com/defytheflow'
export GITCONF="${XDG_CONFIG_HOME}"/git/config    # config file

# Less
export LESSHISTFILE="${XDG_CACHE_HOME}"/less/history

# Python
export PYTHONPATH="${HOME}"/.lib  # include modules
export PYTHONRC="${XDG_CONFIG_HOME}"/python/pythonrc  # config file
export PYTHONSTARTUP="${PYTHONRC}"  # config file

# Shellcheck
export SHELLCHECK_OPTS=''  # run-time options

# Task
export TASKDATA="${XDG_DATA_HOME}"/task
export TASKRC="${XDG_CONFIG_HOME}"/task/taskrc

# Vim
export VIMRC="${HOME}"/.vimrc  # config file.

# Zsh
export ZSHRC="${HOME}"/.zshrc  # config file.
