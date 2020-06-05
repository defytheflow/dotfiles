#!/bin/sh

# File:      .profile
# Created:   28.03.2020
# Author:    Artyom Danilov


# XDG Base Directory {{{
export XDG_CACHE_HOME="${HOME}"/.cache
export XDG_CONFIG_HOME="${HOME}"/.config
export XDG_DATA_HOME="${HOME}"/.local/share

# To use gnome-control-senter in i3 session.
export XDG_CURRENT_DESKTOP=GNOME
#}}}

# Homes {{{
export CARGO_HOME="${XDG_CONFIG_HOME}"/cargo
export DOTFILES_HOME="${HOME}"/.dotfiles
export GEM_HOME="${XDG_CONFIG_HOME}"/gem
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
export PYLINTHOME="${XDG_DATA_HOME}"/pylint
export RUSTUP_HOME="${XDG_CONFIG_HOME}"/rustup
export TASKDATA="${XDG_DATA_HOME}"/task
export ZPLUG_HOME="${XDG_CONFIG_HOME}"/zplug
#}}}

# Defaults {{{
export EDITOR='nvim'
export BROWSER='google-chrome'
export TERMINAL='alacritty'
#}}}

# Paths {{{
export PATH="${PATH}":"${HOME}"/.local/bin:/snap/bin:"${JAVA_HOME}"/bin
export CPATH=''                             # <-- C headers
export LD_LIBRARY_PATH=''                   # <-- C libraries
export PYTHONPATH=''                        # <-- Python modules
#}}}

# Flags {{{
export CFLAGS='-g -W -Wall -Wextra' # <-- C
export SHELLCHECK_OPTS=''           # <-- shellcheck
export PYTHONSTARTUP="${PYTHONRC}"  # <-- python
#}}}

# Configs {{{
export BASHRC="${HOME}"/.bashrc
export ZSHRC="${HOME}"/.zshrc
export VIMRC="${XDG_CONFIG_HOME}"/nvim/init.vim
export PYTHONRC="${XDG_CONFIG_HOME}"/python/pythonrc
export I3CONF="${XDG_CONFIG_HOME}"/i3/config
export GITCONF="${XDG_CONFIG_HOME}"/git/config
export TASKRC="${XDG_CONFIG_HOME}"/task/taskrc
#}}}

# Caches {{{
export ICEAUTHORITY="${XDG_CACHE_HOME}"/ICEauthority
export LESSHISTFILE="${XDG_CACHE_HOME}"/less/history
export ZPLUG_CACHE_DIR="${XDG_CACHE_HOME}"/zplug
#}}}

# Wsl {{{
if [ -n "${WSL_DISTRO_NAME}" ]; then
    WIN_USER="$(powershell.exe '$env:UserName' | sed -e 's/\r//g')"
    export WIN_USER                        # <-- Windows user name.
    WIN_HOME="$(wslpath "$(cmd.exe /C 'echo | set /p _=%USERPROFILE%' 2>/dev/null)")"
    export WIN_HOME                        # <-- Windows home directory.
    export WIN_DESK="${WIN_HOME}"/Desktop  # <-- Windows desktop directory.
    export WIN_PROG_FILES="/mnt/c/Program Files"
    export WIN_PROG_FILES_86="/mnt/c/Program Files (x86)"
fi
#}}}

# Virtualenvwrapper {{{
export WORKON_HOME="${HOME}"/.envs  # virtualenvwrapper
export PROJECT_HOME="${HOME}"/repos # development project directories
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV="${HOME}"/.local/bin/virtualenv
# Must be at the bottom
[ -f "${HOME}"/.local/bin/virtualenvwrapper.sh ] && \
    . "${HOME}"/.local/bin/virtualenvwrapper.sh
#}}}

# So that scripts and programs could use these values (Important).
export LINES COLUMNS
