#!/bin/sh

# File:     install_arch.sh
# Created:  29.07.2020
# Author:   Artyom Danilov (@defytheflow)

. "${PWD}/.profile"

main() {
  check_environ
  check_internet
  update_system
  install_packages
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

install_packages() {
  echo "${0}: Installing pacman packges..."
  for package in \
    'alacritty' \
    'bat' \
    'cargo' \
    'clang' \
    'dmenu' \
    'i3-gaps' \
    'gdb' \
    'mlocate' \
    'nitrogen' \
    'npm' \
    'python-pip' \
    'ripgrep' \
    'rofi' \
    'shellcheck' \
    'shfmt' \
    'tmux' \
    'tree' \
    'valgrind' \
    'xclip' \
    'xcompmgr' \
    'yay' \
    'zathura' \
    'zathura-pdf-mupdf'; do
    sudo pacman -Qi "${package}" >/dev/null || yes | sudo pacman -S "${package}"
  done

  echo "${0}: Installing python packages..."
  for package in \
    'bumblebee-status' \
    'flake8' \
    'flake8-quotes' \
    'ipython' \
    'isort' \
    'mypy' \
    'pipenv' \
    'pydocstyle' \
    'pynvim' \
    'python-language-server' \
    'vim-vint' \
    'yapf'; do
    pip3 show "${package}" >/dev/null || yes | pip3 install "${package}"
  done

  echo "${0}: Installing npm packages..."
  for package in \
    'prettier' \
    'neovim'; do
    npm list -g "${package}" >/dev/null || yes | sudo npm install -g "${package}"
  done

  command -v exa >/dev/null || cargo install exa
  command -v code >/dev/null || yay code
  command -v nvim >/dev/null || install_neovim
  command -v zsh >/dev/null || install_zsh
}

install_neovim() {
  echo "${0}: Installing neovim..."
  sudo pacman -S neovim python-neovim &&
    sudo ln -sf "$(which nvim)" '/usr/bin/vim'
}

install_zsh() {
  echo "${0}: Installing zsh..."
  sudo pacman -S zsh fonts-powerline &&
    sudo chsh -s "$(which zsh)"
}

create_dirs() {
  echo "${0}: Creating cache directories..."
  create_dir_if_not_exists "${HOME}/.local/bin"
  create_dir_if_not_exists "${XDG_CONFIG_HOME}/yapf"
  for prog in 'bash' 'less' 'postgres' 'python' 'zsh'; do
    create_dir_if_not_exists "${XDG_CACHE_HOME}/${prog}"
  done
}

create_symlinks() {
  echo "${0}: Creating dotfiles symlinks..."

  ln -sf "${DOTFILES_HOME}/bash/.bashrc" "${HOME}/.bashrc"
  ln -sf "${DOTFILES_HOME}/clang/.clang-format" "${HOME}/.clang-format"
  ln -sf "${DOTFILES_HOME}/python/flake8" "${XDG_CONFIG_HOME}/flake8"
  ln -sf "${DOTFILES_HOME}/python/pycodestyle" "${XDG_CONFIG_HOME}/pycodestyle"
  ln -sf "${DOTFILES_HOME}/python/style.yapf" "${XDG_CONFIG_HOME}/yapf/style"
  ln -sf "${DOTFILES_HOME}/user-dirs.dirs" "${XDG_CONFIG_HOME}/user-dirs.dirs"

  # ln -sf "${DOTFILES_HOME}/vscode/settings.json" "${XDG_CONFIG_HOME}/Code/User/settings.json"
  # ln -sf "${DOTFILES_HOME}/vscode/snippets" "{XDG_CONFIG_HOME}/Code/User/snippets"
  # ln -sf "${DOTFILES_HOME}/vscode/keybindings.json" "{XDG_CONFIG_HOME}/Code/User/keybindings.json"

  for file in '.profile' '.xprofile'; do
    ln -sf "${DOTFILES_HOME}/${file}" "${HOME}/${file}"
  done

  for dir in 'alacritty' 'i3' 'git' 'nvim' 'python' 'tmux' 'zsh'; do
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
