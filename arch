#!/bin/sh

# File:         arch.sh
# Created:      29.07.2020
# Author:       Artyom Danilov (@defytheflow)
# Description:  Installation functions for arch-based distros.

update_system() {
  if command -v yay >/dev/null; then
    yay -Syu --noconfirm && yay -Yc --noconfirm
  else
    sudo pacman -Syu --noconfirm
  fi
}

install_packages() {
  log 'Installing arch packages.'

  install_pacman_package() {
    log "Checking that $(color "${1}") exists."

    if ! sudo pacman -Qi "${1}" >/dev/null; then
      sudo pacman -S "${1}"
    fi
  }

  install_aur_package() {
    log "Checking that $(color "${1}") exists."

    if ! yay -Qi "${1}" >/dev/null; then
      yay -S --noconfirm "${1}"
    fi
  }

  install_neovim() {
    log "Checking that $(color 'neovim') exists."

    if ! command -v nvim >/dev/null; then
      sudo pacman -S neovim python-neovim
      sudo ln -sf "$(command -v nvim)" "$(command -v vim)"
    fi
  }

  install_zsh() {
    log "Checking that $(color 'zsh') exists."

    if ! command -v zsh >/dev/null; then
      sudo pacman -S zsh fonts-powerline
      sudo chsh -s "$(command -v zsh)"
    fi
  }

  install_neovim
  install_zsh

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
    install_pacman_package "${package}"
  done

  for package in \
    'code' \
    'rmtrash'; do
    install_aur_package "${package}"
  done
}
