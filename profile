#!/bin/sh

# File:      .profile
# Created:   28.03.2020
# Author:    Artyom Danilov


# path
export PATH="${PATH}":"${HOME}"/.local/bin
export PATH="${PATH}":"${JAVA_HOME}"/bin

# xdg
export XDG_CACHE_HOME="${HOME}"/.cache
export XDG_CONFIG_HOME="${HOME}"/.config
export XDG_DATA_HOME="${HOME}"/.local/share
export XDG_CURRENT_DESKTOP=GNOME  # To use gnome-control-senter in i3 session.

# homes
export CARGO_HOME="${XDG_CONFIG_HOME}"/cargo
export DOTFILES_HOME="${HOME}"/.dotfiles
export GEM_HOME="${XDG_CONFIG_HOME}"/gem
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
export PYLINTHOME="${XDG_DATA_HOME}"/pylint
export RUSTUP_HOME="${XDG_CONFIG_HOME}"/rustup
export TASKDATA="${XDG_DATA_HOME}"/task
export ZPLUG_HOME="${XDG_CONFIG_HOME}"/zplug
export WALLPAPER_HOME="${XDG_CONFIG_HOME}"/wallpaper

# defaults
export EDITOR='nvim'
export BROWSER='google-chrome'
export READER='zathura'
export TERMINAL='alacritty'

# paths
export CPATH=
# For neovim c/c++ autocomplete
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}":/usr/lib/llvm-3.9/lib
export PYTHONPATH=

# flags
export CFLAGS='-g -W -Wall -Wextra'
export SHELLCHECK_OPTS=''
export PYTHONSTARTUP="${PYTHONRC}"

# configs
export BASHRC="${HOME}"/.bashrc
export ZSHRC="${HOME}"/.zshrc
export VIMRC="${XDG_CONFIG_HOME}"/nvim/init.vim
export PYTHONRC="${XDG_CONFIG_HOME}"/python/pythonrc
export I3CONF="${XDG_CONFIG_HOME}"/i3/config
export GITCONF="${XDG_CONFIG_HOME}"/git/config
export TASKRC="${XDG_CONFIG_HOME}"/task/taskrc

# caches
export ICEAUTHORITY="${XDG_CACHE_HOME}"/ICEauthority
export LESSHISTFILE="${XDG_CACHE_HOME}"/less/history
export ZPLUG_CACHE_DIR="${XDG_CACHE_HOME}"/zplug

# virtualenvwrapper
export WORKON_HOME="${HOME}"/.envs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV="${HOME}"/.local/bin/virtualenv

# wsl
if [ -n "${WSL_DISTRO_NAME}" ]; then
    export WIN_USER="$(powershell.exe '$env:UserName' | sed -e 's/\r//g')"
    export WIN_HOME="$(wslpath "$(cmd.exe /C 'echo | set /p _=%USERPROFILE%' 2>/dev/null)")"
    export WIN_DESK="${WIN_HOME}"/Desktop
    export WIN_PROG_FILES='/mnt/c/Program Files'
    export WIN_PROG_FILES_86='/mnt/c/Program Files (x86)'
fi

export LINES COLUMNS  # For use by scripts and programs. (!)
