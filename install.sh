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


download_zsh_plugins() {
    [ ! -d "${ZSH_PLUGINS}" ] && mkdir "${ZSH_PLUGINS}"

    [ ! -d "${ZSH_PLUGINS}"/zsh-syntax-highlighting ] && \
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "${ZSH_PLUGINS}"/zsh-syntax-highlighting

    [ ! -d "${ZSH_PLUGINS}"/zsh-autosuggestions ] && \
        git clone https://github.com/zsh-users/zsh-autosuggestions \
        "${ZSH_PLUGINS}"/zsh-autosuggestions

    [ ! -d "${ZSH_PLUGINS}"/alias-tips ] && \
        git clone https://github.com/djui/alias-tips.git \
        "${ZSH_PLUGINS}"/alias-tips

    [ ! -d "${ZSH_PLUGINS}"/command-not-found ] && \
        mkdir "${ZSH_PLUGINS}"/command-not-found && \
        url=https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master && \
        url="${url}"/plugins/command-not-found/command-not-found.plugin.zsh && \
        wget -P "${ZSH_PLUGINS}"/command-not-found "${url}"
}


create_symlinks
[ "${SHELL}" = /usr/bin/zsh ] && download_zsh_plugins
exit 0
