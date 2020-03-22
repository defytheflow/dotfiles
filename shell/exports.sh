#!/usr/bin/zsh

# -----------------------------------------------------------------------------
# | File:      exports.sh
# ----------------------------------------------------------------------------
# | Modified:  March 20, 2020
# ----------------------------------------------------------------------------
# | Author:    Artyom Danilov
# ----------------------------------------------------------------------------

echo "Running ${0}"

# ---------------------------------------------------------------------------- #
#                                    shell                                     #
# ---------------------------------------------------------------------------- #

# Don't save duplicate lines or lines starting with whitespace in the history.
export HISTCONTROL='ignoredups'

# Number of lines or commands that are stored in memory in a history list while
# your bash session is ongoing.
export HISTSIZE=10000

# Number of lines or commands that are allowed in the history file at startup
# time of a session and are stored in the history files at the end of your
# bash session for use in future sessions.
export HISTFILESIZE=10000

# Configuration files.
export ALIAS="${HOME}/.dotfiles/shell/aliases.sh"
export EXPORT="${HOME}/.dotfiles/shell/exports.sh"
export FUNC="${HOME}/.dotfiles/shell/functions.sh"
export PROM="${HOME}/.dotfiles/shell/prompt.sh"
export WSL="${HOME}/.dotfiles/shell/wsl.sh"

export BASHRC="${HOME}/.bashrc"
export ZSHRC="${HOME}/.zshrc"
# export PROFILE="${HOME}/.bash_profile"

# ---------------------------------------------------------------------------- #
#                                      c                                       #
# ---------------------------------------------------------------------------- #

# Compilation flags.
export CFLAGS='-W -Wall -Wextra'
# Search for includes here.
export CPATH="${HOME}/.lib/"
# Link libraries from here.
export LD_LIBRARY_PATH="${HOME}/.lib"

# ---------------------------------------------------------------------------- #
#                                     git                                      #
# ---------------------------------------------------------------------------- #

# My github.
export GITHUB='https://github.com/defytheflow'
# My git-tracked projects directory.
export GITD="${HOME}/dev/git/"
# My current git-projects.
export DOT="${GITD}/dotfiles"
export SCH="${GITD}/school"
export SDK="${GITD}/sdk"

# ---------------------------------------------------------------------------- #
#                                    python                                    #
# ---------------------------------------------------------------------------- #

# Search python modules here.
export PYTHONPATH="${HOME}/.lib/"
# Run commands file.
export PYRC="${HOME}/.dotfiles/python/pythonrc"
# Run this 'commands' file when starting interpreter.
export PYTHONSTARTUP="${PYRC}"

# ---------------------------------------------------------------------------- #
#                                  shellcheck                                  #
# ---------------------------------------------------------------------------- #

# 1090 - can't follow source, 2034 - unused variable
export SHELLCHECK_OPTS="-e SC2034 -e SC1090"

# ---------------------------------------------------------------------------- #
#                                     vim                                      #
# ---------------------------------------------------------------------------- #

# Use this as default editor by other programs.
export EDITOR='vim'
# Condifuration file.
export VIMRC="${HOME}/.vimrc"
