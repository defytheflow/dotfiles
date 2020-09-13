#!/bin/sh

# File:         install.sh
# Created:      12.09.2020
# Author:       Artyom Danilov (@defytheflow)

. "$(dirname "${0}")/.profile"

log() {
  format='%s\n'
  while getopts 'e' opt; do
    case $opt in
      e)
        format='%b' ;;
      *)
        return 1
    esac
  done
  shift $((OPTIND - 1))
  printf "${format}" "install: ${*}"
}

color() {
  echo "$(tput setaf 26)${1}$(tput setaf 15)"
}

main() {
  check_distro
  check_environ
  check_internet
  update_system
  install_packages
  install_python_packages
  install_npm_packages
  create_dirs
  create_symlinks
}

check_distro() {
  log 'Checking distribution.'
  distro=$(lsb_release -d | awk '{ print $2 }')
  case "${distro}" in
  'Manjaro')
    . "$(dirname "${0}")/arch.sh"
    ;;
  'Ubuntu')
    . "$(dirname "${0}")/debian.sh"
    ;;
  *)
    echo "${0}: Linux distribution '${distro}' is not supported."
    return 1
    ;;
  esac
  log "Distribution: $(color "${distro}")"
}

check_environ() {
  log 'Checking evironment variables.'
  if [ -z "${DOTFILES_HOME}" ]; then
    log 'DOTFILES_HOME environment variable has not been set.'
    return 1
  fi
}

check_internet() {
  log 'Checking internet connection.'
  if ! wget -q --spider https://google.com; then
    log 'no internet connection.'
    return 1
  fi
}

install_python_packages() {
  log 'Installing python packages.'
  for package in \
    'bumblebee-status' \
    'flake8' \
    'flake8-quotes' \
    'httpie' \
    'ipdb' \
    'ipython' \
    'isort' \
    'pipenv' \
    'pynvim' \
    'python-language-server' \
    'vim-vint' \
    'yapf'; do
    install_python_package_if_not_exists "${package}"
  done
}

install_npm_packages() {
  log 'Installing npm packages.'
  for package in \
    'prettier' \
    'neovim'; do
    install_npm_package_if_not_exists "${package}"
  done
}

install_python_package_if_not_exists() {
  log "Checking that $(color "${1}") exists."
  if ! python3 -m pip list | grep "${1}" >/dev/null; then
    yes | python3 -m pip install "${1}"
  fi
}

install_npm_package_if_not_exists() {
  log "Checking that $(color "${1}") exists."
  if ! npm list -g "${1}" >/dev/null; then
    yes | sudo npm install -g "${1}"
  fi
}

create_dirs() {
  log 'Creating directories.'
  create_dir_if_not_exists "${HOME}/.local/bin"
  create_dir_if_not_exists "${XDG_CONFIG_HOME}/yapf"
  for prog in 'bash' 'less' 'postgres' 'python' 'zsh'; do
    create_dir_if_not_exists "${XDG_CACHE_HOME}/${prog}"
  done
}

create_symlinks() {
  log 'Creating symlinks.'

  symlink_file "${DOTFILES_HOME}/bash/.bashrc" "${HOME}/.bashrc"
  symlink_file "${DOTFILES_HOME}/clang/.clang-format" "${HOME}/.clang-format"
  symlink_file "${DOTFILES_HOME}/python/flake8" "${XDG_CONFIG_HOME}/flake8"
  symlink_file "${DOTFILES_HOME}/python/pycodestyle" "${XDG_CONFIG_HOME}/pycodestyle"
  symlink_file "${DOTFILES_HOME}/python/style.yapf" "${XDG_CONFIG_HOME}/yapf/style"
  symlink_file "${DOTFILES_HOME}/user-dirs.dirs" "${XDG_CONFIG_HOME}/user-dirs.dirs"
  symlink_file "${DOTFILES_HOME}/ipython/ipython_config.py" "${IPYTHONDIR}/profile_default/ipython_config.py"

  # symlink_file "${DOTFILES_HOME}/vscode/settings.json" "${XDG_CONFIG_HOME}/Code/User/settings.json"
  # symlink_file "${DOTFILES_HOME}/vscode/snippets" "{XDG_CONFIG_HOME}/Code/User/snippets"
  # symlink_file "${DOTFILES_HOME}/vscode/keybindings.json" "{XDG_CONFIG_HOME}/Code/User/keybindings.json"

  for file in '.inputrc' '.profile' '.xprofile' '.zprofile'; do
    symlink_file "${DOTFILES_HOME}/${file}" "${HOME}/${file}"
  done

  # to not override other people git config.
  if [ "${USER}" = 'defytheflow' ]; then
    symlink_dir "${DOTFILES_HOME}/git" "${XDG_CONFIG_HOME}/git"
  fi

  for dir in 'alacritty' 'i3' 'nvim' 'python' 'tmux' 'zsh'; do
    symlink_dir "${DOTFILES_HOME}/${dir}" "${XDG_CONFIG_HOME}/${dir}"
  done
}

symlink_file() {
  log "Symlinking $(color "${2}") file."
  ln -sf "${1}" "${2}"
}

symlink_dir() {
  log "Symlinking $(color "${2}") directory."
  [ -d "${2}" ] && rm -r "${2}"
  ln -sf "${1}" "${2}"
}

create_dir_if_not_exists() {
  log "Creating $(color "${1}") directory."
  [ -d "${1}" ] || mkdir -p "${1}"
}

main
