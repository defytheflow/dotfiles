#!/usr/bin/env sh

# File:     arch
# Created:  29.07.2020
# Author:   Artyom Danilov (@defytheflow)

. "$(dirname "${0}")/utils.sh"

log "Running ${1} module."

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
    alacritty apache awesome \
    bat \
    cargo chromium clang \
    dash \
    fd fzf \
    i3-gaps i3lock i3status \
    jq \
    gdb \
    luarocks \
    maven mlocate \
    neovim nitrogen npm \
    opam \
    php powerline-fonts python-neovim python-pip \
    ranger ripgrep rofi ruby \
    screenkey shellcheck shfmt \
    tk tmux tokei tree ttf-fira-code \
    ueberzug \
    valgrind vim vi \
    xclip xcompmgr \
    yay \
    zathura zathura-pdf-mupdf zsh

  for package; do
    log "Checking that $(color "${package}") exists."
    sudo pacman -Qi "${package}" >/dev/null || sudo pacman -S --noconfirm "${package}"
  done

  set -- code rmtrash betterlockscreen java-language-server ccrypt

  for package; do
    log "Checking that $(color "${package}") AUR package exists."
    yay -Qi "${package}" >/dev/null || yay -S --noconfirm "${package}"
  done
}
