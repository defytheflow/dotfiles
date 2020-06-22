#!/bin/sh

# File:      install.sh
# Created:   26.03.2020
# Author:    Artyom Danilov


# Load environment variables. (XDG_CACHE_HOME, XDG_CONFIG_HOME, DOTFILES_HOME...)
. "$(pwd)"/.profile

create_directories() {
    for prog in 'zsh' 'bash'; do
        [ -d "${XDG_CACHE_HOME}"/"${prog}" ] || mkdir -p "${XDG_CACHE_HOME}"/"${prog}"
    done
}

create_symlinks() {
    ln -sf "${DOTFILES_HOME}"/bash/bashrc      "${HOME}"/.bashrc
    ln -sf "${DOTFILES_HOME}"/.profile         "${HOME}"/.profile
    ln -sf "${DOTFILES_HOME}"/.xprofile        "${HOME}"/.xprofile
    ln -sf "${DOTFILES_HOME}"/.zprofile        "${HOME}"/.zprofile
    ln -sf "${DOTFILES_HOME}"/nvim             "${XDG_CONFIG_HOME}"/nvim
    ln -sf "${DOTFILES_HOME}"/zsh              "${XDG_CONFIG_HOME}"/zsh
    ln -sf "${DOTFILES_HOME}"/git              "${XDG_CONFIG_HOME}"/git
    ln -sf "${DOTFILES_HOME}"/tmux             "${XDG_CONFIG_HOME}"/tmux
    ln -sf "${DOTFILES_HOME}"/python           "${XDG_CONFIG_HOME}"/python
    ln -sf "${DOTFILES_HOME}"/vim              "${XDG_CONFIG_HOME}"/vim
}

install_software() {
    for prog in 'highlight' 'nvim' 'tree' 'xclip' 'zsh'; do
        command -v "${prog}" >/dev/null || sudo apt-get install "${prog}"
    done
}

create_directories
create_symlinks
install_software
