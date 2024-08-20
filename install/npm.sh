#!/usr/bin/env bash

# File:     npm.sh
# Created:  20.08.2024
# Author:   Artyom Danilov (@defytheflow)

. "$(dirname "${0}")/utils.sh"

log "Running ${1} module."

install_npm_packages() {
  log 'Installing npm packages.'

  packages=(
    @antfu/ni # `ni` - use the right package manager
    bash-language-server
    eslint
    jest
    jsonlint
    live-server
    nodemon
    npm-check-updates # `ncu` - upgrades package.json dependencies to the latest versions
    npkill # - easily find and remove old and heavy node_modules folders
    pnpm
    prettier
    neovim
    sass
    serve
    stylelint
    typescript
    trash-cli
    ts-node
    vim-language-server
  )

  for package in ${packages[@]}; do
    log "Checking that $(color "${package}") exists."
    npm list --global "${package}" >/dev/null || sudo npm install --global "${package}"
  done
}
