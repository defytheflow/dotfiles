#!/bin/sh

# File:         debian.sh
# Created:      26.03.2020
# Author:       Artyom Danilov (@defytheflow)
# Description:  Installation functions for debian-based distros.

update_system() {
  printf '%s' "${0}: Update system? [y/n] " && read -r ans
  if [ "${ans}" = 'y' ] || [ "${ans}" = 'Y' ]; then
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get autoremove -y
  fi
}

install_packages() {
  echo "${0}: Installing apt-get packages."
  for package in \
    'cargo' \
    'clang' \
    'gdb' \
    'jq' \
    'mlocate' \
    'nitrogen' \
    'npm' \
    'python3-pip' \
    'shellcheck' \
    'tmux' \
    'tree' \
    'valgrind' \
    'xclip'; do
    sudo dpkg -S "${package}" >/dev/null 2>&1 || sudo apt-get install -y "${package}"
  done

  command -v alacritty >/dev/null || install_alacritty
  command -v bat >/dev/null || install_bat
  command -v nvim >/dev/null || install_neovim
  command -v zsh >/dev/null || install_zsh
}

install_alacritty() {
  echo "${0}: Installing alacritty."

  if [ -n "${WSL_DISTRO_NAME}" ]; then
    echo "${0}: Alacritty installation is not supported for WSL."
    return 1
  fi

  link='https://github.com/alacritty/alacritty/releases/download/v0.4.3'
  deb='Alacritty-v0.4.3-ubuntu_18_04_amd64.deb'

  wget "${link}/${deb}" && sudo dpkg -i "${deb}" && rm "${deb}"
  sudo update-alternatives \
    --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
}

install_bat() {
  echo "${0}: Installing bat."

  link='https://github.com/sharkdp/bat/releases/download/v0.15.4'
  deb='bat_0.15.4_amd64.deb'

  wget "${link}/${deb}" && sudo dpkg -i "${deb}" && rm "${deb}"
}

install_neovim() {
  echo "${0}: Installing neovim."
  sudo add-apt-repository -y ppa:neovim-ppa/stable
  sudo apt-get update
  sudo apt-get install -y neovim python3-neovim
  sudo pip3 install pynvim
}

install_zsh() {
  echo "${0}: Installing zsh..."
  sudo apt-get install -y zsh fonts-powerline &&
    sudo chsh -s "$(which zsh)"
}
