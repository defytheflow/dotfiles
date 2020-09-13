#!/bin/sh

# File:     .profile
# Created:  28.03.2020
# Author:   Artyom Danilov (@defytheflow)

# xdg.
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

# mine.
export CODE_HOME="${HOME}/code"
export DOTFILES_HOME="${HOME}/.dotfiles"
export WALLPAPER_HOME="${XDG_CONFIG_HOME}/wallpaper"

# path.
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:${XDG_CONFIG_HOME}/cargo/bin"
export PATH="${PATH}:${PYENV_ROOT}/bin"

# default.
export EDITOR='vim'
export BROWSER='firefox'
export PAGER='less'

# cargo.
export CARGO_HOME="${XDG_CONFIG_HOME}/cargo"

# gnupg.
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"

# ipython.
export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"

# java.
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre

# less.
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"

# make.
export CC='gcc'
export CXX='g++'
export CFLAGS='-g -W -Wall -Wextra -Wpedantic -std=c11'
export CXXFLAGS='-g -W -Wall -Wextra -Wpedantic'
export LDLIBS='-lm -lncurses -lsqlite3 -lcurl'

# man.
if command -v bat >/dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# node.
export NODE_REPL_HISTORY="${XDG_CACHE_HOME}/node_repl_history"

# pipenv.
export PIPENV_VENV_IN_PROJECT=1
export PIPENV_VERBOSITY=-1

# postgres.
export PSQL_HISTORY="${XDG_CACHE_HOME}/postgres/psql_history"

# pyenv.
export PYENV_ROOT="${XDG_CONFIG_HOME}/pyenv"

# pylint.
export PYLINTHOME="${XDG_DATA_HOME}/pylint"

# python.
export PYTHONPATH=
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"

# ruby.
export GEM_HOME="${XDG_CONFIG_HOME}/gem"

# shellcheck.
export SHELLCHECK_OPTS='--exclude=SC1072,SC1073,SC1090,SC1091'

# zsh.
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# zplug.
export ZPLUG_HOME="${XDG_CONFIG_HOME}/zplug"
export ZPLUG_CACHE_DIR="${XDG_CACHE_HOME}/zplug"

# ?.
export ICEAUTHORITY="${XDG_CACHE_HOME}/ICEauthority"

# wsl.
if [ -n "${WSL_DISTRO_NAME}" ]; then
  export LS_COLORS="ow=01;94:di=01;94" # fix dirs colors.
  export WIN_USER="$(powershell.exe '$env:UserName' | sed -e 's/\r//g')"
  export WIN_HOME="$(wslpath "$(cmd.exe /C 'echo | set /p _=%USERPROFILE%' 2>/dev/null)")"
  export WIN_DESK="${WIN_HOME}"/Desktop
fi

export LINES COLUMNS # For use by external scripts and programs. (!)
