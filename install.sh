#!/bin/sh

# File:         install.sh
# Created:      12.09.2020
# Author:       Artyom Danilov (@defytheflow)

. "$(dirname "${0}")/.profile"

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
  printf '%s' "${0}: Checking distribution. "
  distro=$(lsb_release -d | awk '{ print $2 }')
  case "${distro}" in
    'Manjaro')
      . "$(dirname "${0}")/arch.sh" ;;
    'Ubuntu')
      . "$(dirname "${0}")/debian.sh" ;;
    *)
      echo '[ FAIL ]'
      echo "${0}: Linux distribution '${distro}' is not supported."
      return 1;
  esac
  echo "[ ${distro} ]"
}

check_environ() {
  printf '%s' "${0}: Checking environment variables. "
  if [ -z "${DOTFILES_HOME}" ]; then
    echo '[ FAIL ]'
    echo "${0}: DOTFILES_HOME environment variable has not been set." >&2
    exit 1
  fi
  echo '[ OK ]'
}

check_internet() {
  printf '%s' "${0}: Checking internet connection. "
  if ! wget -q --spider https://google.com; then
    echo '[ FAIL ]'
    echo "${0}: no internet connection" >&2
    exit 1
  fi
  echo '[ OK ]'
}

install_python_packages() {
  echo "${0}: Installing python packages."
  for package in \
    'bumblebee-status' \
    'flake8' \
    'flake8-quotes' \
    'httpie' \
    'ipdb' \
    'ipython' \
    'isort' \
    'mypy' \
    'pipenv' \
    'pydocstyle' \
    'pynvim' \
    'python-language-server' \
    'vim-vint' \
    'yapf'; do
    python3 -m pip list | grep "${package}" >/dev/null || yes | python3 -m pip install "${package}"
  done
}

install_npm_packages() {
  echo "${0}: Installing npm packages."
  for package in \
    'prettier' \
    'neovim'; do
    npm list -g "${package}" >/dev/null || yes | sudo npm install -g "${package}"
  done
}

create_dirs() {
  printf '%s' "${0}: Creating cache directories. "
  create_dir_if_not_exists "${HOME}/.local/bin"
  create_dir_if_not_exists "${XDG_CONFIG_HOME}/yapf"
  for prog in 'bash' 'less' 'postgres' 'python' 'zsh'; do
    create_dir_if_not_exists "${XDG_CACHE_HOME}/${prog}"
  done
  echo '[ OK ]'
}

create_symlinks() {
  printf '%s' "${0}: Creating dotfiles symlinks. "

  ln -sf "${DOTFILES_HOME}/bash/.bashrc" "${HOME}/.bashrc"
  ln -sf "${DOTFILES_HOME}/clang/.clang-format" "${HOME}/.clang-format"
  ln -sf "${DOTFILES_HOME}/python/flake8" "${XDG_CONFIG_HOME}/flake8"
  ln -sf "${DOTFILES_HOME}/python/pycodestyle" "${XDG_CONFIG_HOME}/pycodestyle"
  ln -sf "${DOTFILES_HOME}/python/style.yapf" "${XDG_CONFIG_HOME}/yapf/style"
  ln -sf "${DOTFILES_HOME}/user-dirs.dirs" "${XDG_CONFIG_HOME}/user-dirs.dirs"
  ln -sf "${DOTFILES_HOME}/ipython/ipython_config.py" "${IPYTHONDIR}/profile_default/ipython_config.py"

  # ln -sf "${DOTFILES_HOME}/vscode/settings.json" "${XDG_CONFIG_HOME}/Code/User/settings.json"
  # ln -sf "${DOTFILES_HOME}/vscode/snippets" "{XDG_CONFIG_HOME}/Code/User/snippets"
  # ln -sf "${DOTFILES_HOME}/vscode/keybindings.json" "{XDG_CONFIG_HOME}/Code/User/keybindings.json"

  for file in '.inputrc' '.profile' '.xprofile' '.zprofile'; do
    ln -sf "${DOTFILES_HOME}/${file}" "${HOME}/${file}"
  done

  for dir in 'alacritty' 'i3' 'git' 'nvim' 'python' 'tmux' 'zsh'; do
    symlink_dir "${DOTFILES_HOME}/${dir}" "${XDG_CONFIG_HOME}/${dir}"
  done

  echo '[ OK ]'
}

symlink_dir() {
  [ -d "${2}" ] && rm -r "${2}"
  ln -sf "${1}" "${2}"
}

create_dir_if_not_exists() {
  [ -d "${1}" ] || mkdir -p "${1}"
}

main
