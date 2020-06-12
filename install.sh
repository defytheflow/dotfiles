#!/bin/sh

# File:      install.sh
# Created:   26.03.2020
# Author:    Artyom Danilov


# Load environment variables. (XDG_CACHE_HOME, XDG_CONFIG_HOME, DOTFILES_HOME...)
. "$(pwd)"/profile

create_directories() {
    for prog in 'zsh' 'bash'; do
        [ -d "${XDG_CACHE_HOME}"/"${prog}" ] || mkdir -p "${XDG_CACHE_HOME}"/"${prog}"
    done

    for prog in 'tmux' 'git' 'python' 'nvim'; do
        [ -d "${XDG_CONFIG_HOME}"/"${prog}" ] || mkdir -p "${XDG_CONFIG_HOME}"/"${prog}"
    done
}

create_symlinks() {
    ln -sf "${DOTFILES_HOME}"/profile         "${HOME}"/.profile
    ln -sf "${DOTFILES_HOME}"/xprofile        "${HOME}"/.xprofile
    ln -sf "${DOTFILES_HOME}"/zshenv          "${HOME}"/.zshenv
    ln -sf "${DOTFILES_HOME}"/bash/bashrc     "${HOME}"/.bashrc
    ln -sf "${DOTFILES_HOME}"/zsh/zshrc       "${HOME}"/.zshrc
    ln -sf "${DOTFILES_HOME}"/nvim/init.vim   "${XDG_CONFIG_HOME}"/nvim/init.vim
    ln -sf "${DOTFILES_HOME}"/tmux/tmux.conf  "${XDG_CONFIG_HOME}"/tmux/tmux.conf
    ln -sf "${DOTFILES_HOME}"/git/config      "${XDG_CONFIG_HOME}"/git/config
    ln -sf "${DOTFILES_HOME}"/python/pythonrc "${XDG_CONFIG_HOME}"/python/pythonrc
}

install_software() {
    for prog in 'highlight' 'nvim' 'tree'; do
        command -v "${prog}" >/dev/null || sudo apt-get install "${prog}"
    done
}

create_directories
create_symlinks
install_software
