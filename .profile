#!/bin/sh

# File:     .profile
# Created:  28.03.2020
# Author:   Artyom Danilov (@defytheflow)

# xdg.
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

# mine.
export DOTFILES_HOME="${HOME}/.dotfiles"
export WALLPAPER_HOME="${XDG_CONFIG_HOME}/wallpaper"

# path.
export PATH="${JAVA_HOME}/bin:${PATH}"
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:${XDG_CONFIG_HOME}/cargo/bin"
export PATH="${PATH}:${PYENV_ROOT}/bin"

# default.
export EDITOR='nvim'
export BROWSER='firefox'
export PAGER='less'
export TERM='alacritty'

# cargo.
export CARGO_HOME="${XDG_CONFIG_HOME}/cargo"

# gnupg.
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"

# ipython.
export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"

# java.
export JAVA_HOME=/usr/lib/jvm/java-14-openjdk
export JRE_HOME=/usr/lib/jvm/java-14-openjdk-amd64/jre

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

LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
export LS_COLORS
