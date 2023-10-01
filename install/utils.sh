#!/usr/bin/env sh

# File:     utils
# Created:  12.09.2020
# Author:   Artyom Danilov (@defytheflow)

log() {
  green='82'
  echo "$(tput setaf ${green})install$(tput setaf 15): ${*}"
}

err() {
  red='125'
  echo "$(tput setaf ${red})error$(tput setaf 15): ${*}"
}

warn() {
  orange='214'
  echo "$(tput setaf ${orange})warning$(tput setaf 15): ${*}" >&2
}

color() {
  blue='26'
  echo "$(tput setaf ${blue})${1}$(tput setaf 15)"
}

symlink() {
  ln -sfvn "${DOTFILES_HOME}/${1}" "${2}"
}

makedir() {
  mkdir -vp "${1}"
}
