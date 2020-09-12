#!/bin/sh

# File:         arch.sh
# Created:      29.07.2020
# Author:       Artyom Danilov (@defytheflow)
# Description:  Installation functions for arch-based distros.

update_system() {
  printf '%s' "${0}: Update system? [y/n] " && read -r ans
  if [ "${ans}" = 'y' ] || [ "${ans}" = 'Y' ]; then
    if command -v yay >/dev/null; then
      yay -Syu --noconfirm && yay -Yc --noconfirm
    else
      sudo pacman -Syu --noconfirm
    fi
  fi
}

install_packages() {
  echo "${0}: Installing pacman packges."
  for package in \
    'alacritty' \
    'bat' \
    'cargo' \
    'clang' \
    'dmenu' \
    'i3-gaps' \
    'i3lock' \
    'jq' \
    'gdb' \
    'mlocate' \
    'nitrogen' \
    'npm' \
    'python-pip' \
    'ripgrep' \
    'rofi' \
    'shellcheck' \
    'shfmt' \
    'time' \
    'tk' \
    'tmux' \
    'tree' \
    'valgrind' \
    'xclip' \
    'xcompmgr' \
    'yay' \
    'zathura' \
    'zathura-pdf-mupdf'; do
    sudo pacman -Qi "${package}" >/dev/null || sudo pacman -S "${package}" --noconfirm
  done

  echo "${0}: Installing AUR packages."
  for package in \
    'rmtrash'; do
    yay -Qi "${package}" >/dev/null || yay -S --noconfirm "${package}"
  done

  command -v code >/dev/null || yay code
  command -v nvim >/dev/null || install_neovim
  command -v zsh >/dev/null || install_zsh
}

install_neovim() {
  echo "${0}: Installing neovim..."
  sudo pacman -S neovim python-neovim &&
    sudo ln -sf "$(which nvim)" "$(which vim)"
}

install_zsh() {
  echo "${0}: Installing zsh..."
  sudo pacman -S zsh fonts-powerline &&
    sudo chsh -s "$(which zsh)"
}
