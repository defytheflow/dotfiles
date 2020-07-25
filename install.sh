#!/bin/sh

# File:      install.sh
# Created:   26.03.2020
# Author:    Artyom Danilov


# Load environment variables. (XDG_CACHE_HOME, XDG_CONFIG_HOME, DOTFILES_HOME...)
. "${PWD}"/.profile

# Make sure environment variables loaded correctly.
if [ -z "${DOTFILES_HOME}" ]; then
    echo -e '$DOTFILES_HOME environment variable has not been set properly.\n' \
            'Aborting installation...' 1>&2
    exit 1
fi

create_dirs() {
    for prog in 'bash' 'python' 'vim' 'zsh'; do
        [ -d "${XDG_CACHE_HOME}"/"${prog}" ] || mkdir -p "${XDG_CACHE_HOME}"/"${prog}"
    done
}

create_links() {
    ln -sf "${DOTFILES_HOME}"/bash/bashrc  "${HOME}"/.bashrc
    ln -sf "${DOTFILES_HOME}"/vim "${HOME}"/.vim

    for file in '.profile' '.xprofile' '.zprofile'; do
        ln -sf "${DOTFILES_HOME}"/"${file}" "${HOME}"/"${file}"
    done

    for dir in 'git' 'nvim' 'python' 'tmux' 'vim' 'zsh'; do
        [ -L "${XDG_CONFIG_HOME}"/"${dir}" ] && rm "${XDG_CONFIG_HOME}"/"${dir}"
        ln -sf "${DOTFILES_HOME}"/"${dir}" "${XDG_CONFIG_HOME}"/"${dir}"
    done
}

install_software() {
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get autoremove

    for prog in 'tree' 'vim' 'xclip'; do
        command -v "${prog}" >/dev/null || sudo apt-get install -y "${prog}"
    done

    command -v 'nvim' >/dev/null || install_neovim
    command -v 'zsh'  >/dev/null || install_zsh
}

install_neovim() {
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install -y neovim python3-neovim
    sudo pip3 install pynvim
}

install_zsh() {
    sudo apt-get install -y zsh
    sudo chsh -s $(which zsh)
}

install_fonts() {
    sudo apt-get install -y fonts-powerline     # spaceship prompt
}

create_dirs
create_links
install_fonts
install_software
