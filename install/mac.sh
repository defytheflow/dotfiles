#!/usr/bin/env sh

# File:     mac
# Created:  16.03.2021
# Author:   Artyom Danilov (@defytheflow)

. "$(dirname "${0}")/utils.sh"

log "Running ${1} module."

install_packages() {
  log 'Installing brew packages.'

  install_brew() {
    log "Checking that $(color brew) exists."

    if ! command -v brew >/dev/null; then
      xcode-select --install
      bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
  }

  install_brew

  set -- \
    bat bpython btop \
    ccrypt cloc composer cowsay \
    deno diceware dos2unix \
    exa ex-vi \
    fd fish fortune fzf \
    gh git-delta graphviz \
    iterm2 \
    jq \
    keycastr \
    lolcat lua luarocks \
    mycli mysql \
    neovim node \
    php pipenv pgcli pnpm postgresql \
    ranger rename ripgrep \
    shellcheck shfmt \
    task telnet tlrc tmux tmuxinator tree \
    vapor vint \
    wget

  for package; do
    log "Checking that $(color "${package}") exists."
    brew ls --versions "${package}" >/dev/null || brew install "${package}"
  done
}
