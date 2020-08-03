#!/bin/sh

# File:     install_arch.sh
# Created:  29.07.2020
# Author:   Artyom Danilov (@defytheflow)


. "${PWD}/.profile"

main() {
    check_environ
    check_internet
    update_system
    install_software
    create_dirs
    create_symlinks
}

check_environ() {
    echo "${0}: Checking environment variables..."
    if [ -z "${DOTFILES_HOME}" ]; then
        echo "${0}: DOTFILES_HOME environment variable has not been set." >&2
        exit 1
    fi
}

check_internet() {
    echo "${0}: Checking internet connection..."
    if ! wget -q --spider https://google.com; then
        echo "${0}: no internet connection" >&2
        exit 1
    fi
}

update_system() {
    printf '%s' "${0}: Update system? [y/n] " && read -r ans
    [ "${ans}" = 'y' ] && yes | sudo pacman -Syu
}

install_software() {
    echo "${0}: Installing software..."

    for prog in 'alacritty' 'bat' 'cargo' 'shellcheck' 'tree' 'vim' 'xclip' 'yay'; do
        command -v "${prog}" >/dev/null || sudo pacman -S "${prog}"
    done

    command -v exa    >/dev/null || cargo install exa
    command -v locate >/dev/null || sudo pacman -S mlocate
    command -v pip3   >/dev/null || sudo pacman -S python-pip
    command -v rg     >/dev/null || sudo pacman -S ripgrep
    command -v code   >/dev/null || install_vscode
    command -v nvim   >/dev/null || install_neovim
    command -v zsh    >/dev/null || install_zsh

    install_python_packages
}

install_neovim() {
    echo "${0}: Installing neovim..."
    sudo pacman -S neovim python-neovim && \
    pip3 install pynvim                 && \
    sudo ln -sf "$(which nvim)" "$(which vim)"
}

install_vscode() {
    echo "${0}: Installing vscode..."
    yay code
    dest="${DOTFILES_HOME}/vscode/settings.json"
    src="${XDG_CONFIG_HOME}/Code/User/settings.json"
    ln -sf "${dest}" "${src}"
}

install_zsh() {
    echo "${0}: Installing zsh..."
    sudo pacman -S zsh fonts-powerline && \
    sudo chsh -s "$(which zsh)"
}

install_python_packages() {
    echo "${0}: Installing python packages..."
    for package in 'flake8' 'isort' 'mypy' 'pipenv' 'rope' 'yapf';  do
        pip3 show "${package}" >/dev/null || pip3 install "${package}"
    done
}

create_dirs() {
    echo "${0}: Creating cache directories..."
    create_dir_if_not_exists "${HOME}/.local/bin"
    for prog in 'bash' 'less' 'postgres' 'python' 'zsh'; do
        create_dir_if_not_exists "${XDG_CACHE_HOME}/${prog}"
    done
}

create_symlinks() {
    echo "${0}: Creating dotfiles symlinks..."

    ln -sf "${DOTFILES_HOME}/bash/bashrc"    "${HOME}/.bashrc"
    ln -sf "${DOTFILES_HOME}/user-dirs.dirs" "${XDG_CONFIG_HOME}/user-dirs.dirs"

    for file in '.profile' '.xprofile'; do
        ln -sf "${DOTFILES_HOME}/${file}" "${HOME}/${file}"
    done

    symlink_dir "${DOTFILES_HOME}"/vim "${HOME}"/.vim

    for dir in 'alacritty' 'git' 'nvim' 'python' 'tmux' 'zsh'; do
        symlink_dir "${DOTFILES_HOME}/${dir}" "${XDG_CONFIG_HOME}/${dir}"
    done
}

symlink_dir() {
    [ -d "${2}" ] && rm -r "${2}"
    ln -sf "${1}" "${2}"
}

create_dir_if_not_exists() {
    [ -d "${1}" ] || mkdir -p "${1}"
}

main
