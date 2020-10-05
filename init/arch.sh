#!/bin/sh

# File:     arch.sh
# Created:  29.07.2020
# Author:   Artyom Danilov (@defytheflow)

update_system() {
  log 'Updating arch system.'

  if command -v yay >/dev/null; then
    yay -Syu --noconfirm && yay -Yc --noconfirm
  else
    sudo pacman -Syu --noconfirm
  fi
}

install_packages() {
  log 'Installing arch packages.'

  set -- \
    alacritty \
    bat \
    cargo clang \
    dash \
    i3-gaps i3lock i3status \
    jq \
    gdb \
    mlocate \
    neovim nitrogen npm \
    powerline-fonts python-neovim python-pip \
    ripgrep rofi \
    screenkey shellcheck shfmt \
    tk tmux tree ttf-fira-code \
    valgrind vim vi \
    xclip xcompmgr \
    yay \
    zathura zathura-pdf-mupdf zsh

  for pack; do
    log "Checking that $(color "${pack}") exists."
    sudo pacman -Qi "${pack}" >/dev/null || sudo pacman -S --noconfirm "${pack}"
  done

  set -- code rmtrash betterlockscreen

  for pack; do
    log "Checking that $(color "${pack}") AUR package exists."
    yay -Qi "${pack}" >/dev/null || yay -S --noconfirm "${pack}"
  done
}
