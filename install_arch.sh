#!/bin/sh

# File:     install_arch.sh
# Created:  29.07.2020
# Author:   Artyom Danilov (@defytheflow)


# script name.
__name__='install_arch'

# Load essential environment variables.
. "${PWD}/.profile"

# Make sure environment variables loaded.
if [ -z "${DOTFILES_HOME}" ]; then
    echo -e '$DOTFILES_HOME environment variable has not been set properly.\n' \
            'Aborting installation...' 1>&2
    exit 1
fi

main() {
    check_internet
    update_system
    install_software
    create_dirs
    create_symlinks
}

check_internet() {
    echo "${__name__}: checking your internet connection..."
    if ! wget -q --spider https://google.com; then
        echo "${__name__}: no internet connection" >&2
        exit 1
    fi
}

update_system() {
    read -rep "${__name__}: update system? [y/n] " ans
    if [ "${ans}" = 'y' ]; then
        yes | sudo pacman -Syu
        clear
    fi
}

install_software() {
    for prog in 'alacritty' 'bat' 'cargo' 'tree' 'vim' 'xclip'; do
        command -v "${prog}" >/dev/null || sudo pacman -S "${prog}"
    done

    command -v exa    >/dev/null || cargo install exa
    command -v locate >/dev/null || sudo pacman -S mlocate
    command -v pip3   >/dev/null || sudo pacman -S python-pip
    command -v code   >/dev/null || sudo snap install code --classic
    command -v rg     >/dev/null || sudo snap install ripgrep --classic
    command -v nvim   >/dev/null || install_neovim
    command -v zsh    >/dev/null || install_zsh

    install_python_packages
}

install_neovim() {
    sudo pacman -S neovim python-neovim && \
    pip3 install pynvim                 && \
    sudo ln -sf "$(which nvim)" "$(which vim)"
}

install_zsh() {
    sudo pacman -S zsh fonts-powerline && \
    sudo chsh -s $(which zsh)
}

install_python_packages() {
    for package in 'isort' 'yapf' 'pipenv' 'flake8' 'rope' 'mypy'; do
        command -v "${package}" >/dev/null || pip3 install "${package}"
    done
}

create_dirs() {
    create_dir_if_not_exists "${HOME}/.local/bin"
    for prog in 'bash' 'less' 'postgres' 'python' 'zsh'; do
        create_dir_if_not_exists "${XDG_CACHE_HOME}/${prog}"
    done
}

create_symlinks() {
    ln -sf "${DOTFILES_HOME}/bash/bashrc"    "${HOME}/.bashrc"
    ln -sf "${DOTFILES_HOME}/user-dirs.dirs" "${XDG_CONFIG_HOME}/user-dirs.dirs"

    for file in '.profile' '.xprofile'; do
        ln -sf "${DOTFILES_HOME}/${file}" "${HOME}/${file}"
    done

    symlink_dir "${DOTFILES_HOME}"/vim "${HOME}"/.vim

    for dir in 'alacritty' 'git' 'nvim' 'python' 'tmux' 'zsh'; do
        symlink_dir "${DOTFILES_HOME}/${dir}" "${XDG_CONFIG_HOME}/${dir}"
    done

    if command -v code >/dev/null; then
        dest="${DOTFILES_HOME}"/vscode/settings.json
        src="${XDG_CONFIG_HOME}"/Code/User/settings.json
        ln -sf "${dest}" "${src}"
    fi
}

symlink_dir() {
    [ -d ${2} ] && rm -r ${2}
    ln -sf ${1} ${2}
}

create_dir_if_not_exists() {
    [ -d ${1} ] || mkdir -p ${1}
}

main
