#!/bin/sh

# File:      install.sh
# Purpose:   Install all dotfiles
# Created:   26.03.2020
# Modified:  28.03.2020
# Author:    Artyom Danilov


# Load essential environment variables.
. "$(pwd)"/profile

create_symlinks() {
    ln -sf "${DOTFILES_HOME}"/profile         "${HOME}"/.profile
    ln -sf "${DOTFILES_HOME}"/xprofile        "${HOME}"/.xprofile
    ln -sf "${DOTFILES_HOME}"/bash/bashrc     "${HOME}"/.bashrc
    ln -sf "${DOTFILES_HOME}"/vim/vimrc       "${HOME}"/.vimrc
    ln -sf "${DOTFILES_HOME}"/zsh/zshrc       "${HOME}"/.zshrc
    ln -sf "${DOTFILES_HOME}"/tmux/tmux.conf  "${XDG_CONFIG_HOME}"/tmux/tmux.conf
    ln -sf "${DOTFILES_HOME}"/git/config      "${XDG_CONFIG_HOME}"/git/config
    ln -sf "${DOTFILES_HOME}"/python/pythonrc "${XDG_CONFIG_HOME}"/python/pythonrc
}

create_symlinks
