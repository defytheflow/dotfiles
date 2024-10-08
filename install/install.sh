#!/usr/bin/env sh

# File:         install
# Created:      12.09.2020
# Author:       Artyom Danilov (@defytheflow)

(test $(uname -s) = Darwin)
ON_MAC="${?}"

relative_import() {
  . "$(dirname "${0}")/${1}"
}

relative_import '.profile'
relative_import 'utils.sh'
relative_import 'npm.sh'

main() {
  check_environ
  check_internet

  if [ "${ON_MAC}" ]; then
    relative_import 'mac.sh'
  else
    check_distro
  fi

  if ! [ "${ON_MAC}" ]; then
    printf 'install: Update system? [y/n] ' && read -r ans
    [ "${ans}" = 'y' ] && update_system
  fi

  install_packages
  install_pip_packages
  install_npm_packages
  install_gem_packages
  [ -z "${WSL_DISTRO_NAME}" ] && ! [ "${ON_MAC}" ] && install_cargo_packages

  create_dirs
  create_symlinks
}

check_distro() {
  log 'Checking distribution.'

  distro=$(lsb_release -d)

  case "${distro}" in
    *Manjaro*)
      relative_import 'arch.sh'
      ;;
    *Ubuntu*)
      relative_import 'debian.sh'
      ;;
    *)
      err "Distribution '${distro}' is not supported."
      exit 1
      ;;
  esac
}

check_environ() {
  log 'Checking evironment variables.'

  if [ -z "${DOTFILES_HOME}" ]; then
    err 'DOTFILES_HOME environment variable has not been set.'
    exit 1
  fi
}

check_internet() {
  log 'Checking internet connection.'

  if ! ping -c 1 -q google.com >/dev/null 2>&1; then
    err 'no internet connection.'
    exit 1
  fi
}

install_gem_packages() {
  log 'Installig gem packages.'

  set -- \
    neovim \
    tmuxinator

  for pack; do
    gem install "${pack}"
  done
}

install_pip_packages() {
  log 'Installing pip packages.'

  set -- \
    commitizen \
    flake8 flake8-quotes \
    gunicorn \
    httpie \
    ipdb ipython isort \
    jupyter \
    mypy \
    pipenv pytest
  # To install on m1 mac "CFLAGS='' pip install pynvim"
  pynvim
  # To install on m1 mac "CFLAGS='' pip install python-language-server"
  python-language-server
  tldr \
    vim-vint \
    yapf

  for pack; do
    python3 -m pip list | grep "${pack}" || python3 -m pip install "${pack}"
  done
}

install_cargo_packages() {
  log 'Installing cargo packages.'

  set -- exa

  for pack; do
    command -v "${pack}" || cargo install "${pack}"
  done
}

create_dirs() {
  log 'Creating directories.'

  makedir "${HOME}/.local/bin"
  makedir "${XDG_CONFIG_HOME}/yapf"

  makedir "${XDG_CACHE_HOME}/bash"
  makedir "${XDG_CACHE_HOME}/less"
  makedir "${XDG_CACHE_HOME}/posgres"
  makedir "${XDG_CACHE_HOME}/python"
  makedir "${XDG_CACHE_HOME}/zsh"
}

create_symlinks() {
  log 'Creating symlinks.'

  if command -v code >/dev/null; then
    if [ "${ON_MAC}" ]; then
      dest="${HOME}/Library/Application Support/Code/User"
    elif command -v code-oss >/dev/null; then
      dest="${XDG_CONFIG_HOME}/Code - OSS/User"
    else
      dest="${XDG_CONFIG_HOME}/Code/User"
    fi
    symlink 'vscode' "${dest}"
  fi

  if [ "${USER}" = 'defytheflow' ]; then
    symlink 'git' "${XDG_CONFIG_HOME}/git"
  fi

  symlink 'wm/i3' "${XDG_CONFIG_HOME}/i3"
  symlink 'wm/awesome' "${XDG_CONFIG_HOME}/awesome"

  symlink 'nvim' "${XDG_CONFIG_HOME}/nvim"
  symlink 'tmux' "${XDG_CONFIG_HOME}/tmux"
  symlink 'ranger' "${XDG_CONFIG_HOME}/ranger"
  symlink 'ghc' "${HOME}/.ghc"
  symlink 'pgcli' "${XDG_CONFIG_HOME}/pgcli"
  symlink '.myclirc' "${HOME}/.myclirc"

  if command -v ipython >/dev/null; then
    symlink "lang/python/ipython_config.py" "${IPYTHONDIR}/profile_default/ipython_config.py"
  fi

  symlink 'lang/python' "${XDG_CONFIG_HOME}/python"
  symlink 'lang/python/flake8' "${XDG_CONFIG_HOME}/flake8"
  symlink 'lang/python/pycodestyle' "${XDG_CONFIG_HOME}/pycodestyle"
  symlink 'lang/python/style.yapf' "${XDG_CONFIG_HOME}/yapf/style"

  # Renaming to .prettierrc.js, so that the global configuration file is hidden, and
  # doesn't clutter ls output inside the home directory.
  symlink 'lang/javascript/prettier.config.js' "${HOME}/.prettierrc.js"
  symlink 'lang/javascript/.eslintrc.json' "${HOME}/.eslintrc.json"

  symlink 'lang/c/.clang-format' "${HOME}/.clang-format"
  symlink 'lang/c/.gdbinit' "${HOME}/.gdbinit"

  symlink 'lang/ocaml/.utoprc' "${HOME}/.utoprc"
  symlink 'lang/ocaml/.ocamlinit' "${HOME}/.ocamlinit"

  symlink 'shell/zsh' "${ZDOTDIR}"
  symlink 'shell/zsh/.zprofile' "${HOME}/.zprofile"
  symlink 'shell/bash/.bashrc' "${HOME}/.bashrc"

  symlink 'term/alacritty' "${XDG_CONFIG_HOME}/alacritty"
  symlink 'user-dirs.dirs' "${XDG_CONFIG_HOME}/user-dirs.dirs"

  symlink '.inputrc' "${HOME}/.inputrc"
  symlink '.profile' "${HOME}/.profile"
  symlink '.xprofile' "${HOME}/.xprofile"

  symlink '.sqliterc' "${HOME}/.sqliterc"
}

main
