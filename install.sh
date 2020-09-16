#!/bin/sh

# File:         install.sh
# Created:      12.09.2020
# Author:       Artyom Danilov (@defytheflow)

. "$(dirname "${0}")/.profile"

log() {
  echo "install: ${*}"
}

color() {
  echo "$(tput setaf 26)${1}$(tput setaf 15)"
}

main() {
  check_distro
  check_environ
  check_internet
  printf 'install: %s' 'Update system? [y/n] ' && read -r ans
  [ "${ans}" = 'y' ] && update_system
  install_packages
  install_pip_packages
  install_npm_packages
  create_dirs
  symlink_dirs
  symlink_files
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
      log "Distribution '${distro}' is not supported."
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

install_pip_packages() {
  log 'Installing pip packages.'

  install_pip_package() {
    log "Checking that $(color "${1}") exists."

    if ! python3 -m pip list | grep "${1}" >/dev/null; then
      yes | python3 -m pip install "${1}"
    fi
  }

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
    install_pip_package "${package}"
  done
}

install_npm_packages() {
  log 'Installing npm packages.'

  install_npm_package() {
    log "Checking that $(color "${1}") exists."

    if ! npm list -g "${1}" >/dev/null; then
      yes | sudo npm install -g "${1}"
    fi
  }

  for package in \
    'bash-language-server' \
    'prettier' \
    'neovim' \
    'vim-language-server'; do
    install_npm_package "${package}"
  done
}

create_dirs() {
  log 'Creating directories.'

  create_dir() {
    log "Creating $(color "${1}") directory."
    [ -d "${1}" ] || mkdir -p "${1}"
  }

  create_dir "${HOME}/.local/bin"
  create_dir "${XDG_CONFIG_HOME}/yapf"

  for prog in 'bash' 'less' 'postgres' 'python' 'zsh'; do
    create_dir "${XDG_CACHE_HOME}/${prog}"
  done
}

symlink_dirs() {
  log 'Symlinking directories.'

  symlink_dir() {
    log "Symlinking $(color "${2}") directory."
    [ -d "${2}" ] && rm -r "${2}"
    ln -sf "${1}" "${2}"
  }

  if command -v code >/dev/null; then
    command -v code-oss >/dev/null && dest='Code - OSS/User' || dest='Code/User'
    symlink_dir "${DOTFILES_HOME}/vscode" "${XDG_CONFIG_HOME}/${dest}"
  fi

  # to not override other people git config.
  if [ "${USER}" = 'defytheflow' ]; then
    symlink_dir "${DOTFILES_HOME}/git" "${XDG_CONFIG_HOME}/git"
  fi

  for dir in 'alacritty' 'i3' 'nvim' 'python' 'tmux' 'zsh'; do
    symlink_dir "${DOTFILES_HOME}/${dir}" "${XDG_CONFIG_HOME}/${dir}"
  done
}

symlink_files() {
  log 'Symlinking files.'

  symlink_file() {
    log "Symlinking $(color "${2}") file."
    ln -sf "${1}" "${2}"
  }

  if command -v ipython >/dev/null; then
    dest="${DOTFILES_HOME}/ipython/ipython_config.py"
    src="${IPYTHONDIR}/profile_default/ipython_config.py"
    symlink_file "${dest}" "${src}"
  fi

  symlink_file "${DOTFILES_HOME}/user-dirs.dirs" "${XDG_CONFIG_HOME}/user-dirs.dirs"
  symlink_file "${DOTFILES_HOME}/python/style.yapf" "${XDG_CONFIG_HOME}/yapf/style"

  for file in 'flake8' 'pycodestyle'; do
    symlink_file "${DOTFILES_HOME}/python/${file}" "${XDG_CONFIG_HOME}/${file}"
  done

  symlink_file "${DOTFILES_HOME}/bash/.bashrc" "${HOME}/.bashrc"
  symlink_file "${DOTFILES_HOME}/clang/.clang-format" "${HOME}/.clang-format"

  for file in '.inputrc' '.profile' '.xprofile' '.zprofile'; do
    symlink_file "${DOTFILES_HOME}/${file}" "${HOME}/${file}"
  done
}

main
