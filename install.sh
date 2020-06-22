#!/bin/sh

# File:      install.sh
# Created:   26.03.2020
# Author:    Artyom Danilov


# Load environment variables. (XDG_CACHE_HOME, XDG_CONFIG_HOME, DOTFILES_HOME...)
. "$(pwd)"/.profile

create_dirs() {
    for prog in 'bash' 'python' 'vim' 'zsh'; do
        [ -d "${XDG_CACHE_HOME}"/"${prog}" ] || mkdir -p "${XDG_CACHE_HOME}"/"${prog}"
    done
}

create_links() {
    ln -sf "${DOTFILES_HOME}"/bash/bashrc  "${HOME}"/.bashrc

    for file in '.profile' '.xprofile' '.zprofile'; do
        ln -sf "${DOTFILES_HOME}"/"${file}" "${HOME}"/"${file}"
    done

    for dir in 'git' 'nvim' 'python' 'tmux' 'vim' 'zsh'; do
        [ -L "${XDG_CONFIG_HOME}"/"${dir}" ] && rm "${XDG_CONFIG_HOME}"/"${dir}"
        ln -sf "${DOTFILES_HOME}"/"${dir}" "${XDG_CONFIG_HOME}"/"${dir}"
    done
}

install_software() {
    for prog in 'highlight' 'tree' 'xclip' 'zsh'; do
        command -v "${prog}" >/dev/null || sudo apt-get install "${prog}"
    done
}

create_dirs
create_links
install_software
