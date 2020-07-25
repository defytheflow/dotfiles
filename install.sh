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
    mkdir -p "${HOME}"/.local/bin
    for prog in 'bash' 'python' 'zsh'; do
        [ -d "${XDG_CACHE_HOME}"/"${prog}" ] || mkdir -p "${XDG_CACHE_HOME}"/"${prog}"
    done
}

create_links() {
    ln -sf "${DOTFILES_HOME}"/bash/bashrc  "${HOME}"/.bashrc

    for file in '.profile' '.xprofile' '.zprofile'; do
        ln -sf "${DOTFILES_HOME}"/"${file}" "${HOME}"/"${file}"
    done

    for dir in 'alacritty' 'git' 'nvim' 'python' 'tmux' 'zsh'; do
        [ -L "${XDG_CONFIG_HOME}"/"${dir}" ] && rm "${XDG_CONFIG_HOME}"/"${dir}"
        ln -sf "${DOTFILES_HOME}"/"${dir}" "${XDG_CONFIG_HOME}"/"${dir}"
    done

    ln -sf "${DOTFILES_HOME}"/user-dirs.dirs "${XDG_CONFIG_HOME}"/user-dirs.dirs
}

install_software() {
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get autoremove

    for prog in 'tree' 'xclip'; do
        command -v "${prog}" >/dev/null || sudo apt-get install -y "${prog}"
    done

    command -v 'alacritty' >/dev/null || install_alacritty
    command -v 'bat'       >/dev/null || install_bat
    command -v 'exa'       >/dev/null || install_exa
    command -v 'nvim'      >/dev/null || install_neovim
    command -v 'zsh'       >/dev/null || install_zsh
}

install_alacritty() {
    deb='Alacritty-v0.4.3-ubuntu_18_04_amd64.deb'
    wget "https://github.com/alacritty/alacritty/releases/download/v0.4.3/${deb}"
    sudo dpkg -i "${deb}"
    rm "${deb}"
    sudo update-alternatives \
        --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
}

install_bat() {
    sudo apt-get install -y bat && \
    ln -s /usr/bin/batcat "${HOME}"/.local/bin/bat
}

install_exa() {
    command -v 'cargo' >/dev/null || sudo apt-get install -y cargo
    sudo cargo install exa
}

install_neovim() {
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install -y neovim python3-neovim
    command -v 'pip3' >/vev/null || sudo apt-get install -y python3-pip
    sudo pip3 install pynvim
}

install_zsh() {
    # fonts-powerline for zsh spaceship prompt.
    sudo apt-get install -y zsh fonts-powerline
    sudo chsh -s $(which zsh)
}

create_dirs
create_links
install_software
