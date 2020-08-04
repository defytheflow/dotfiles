#!/bin/sh

# File:     install_deb.sh
# Created:  26.03.2020
# Author:   Artyom Danilov (@defytheflow)


. "${PWD}/.profile"

main() {
  check_environ
  check_internet
  update_system
  install_packages
  create_dirs
  create_symlinks
}

check_environ() {
  echo "${0}: Checking environment variables..."
  if [ -z "${DOTFILES_HOME}" ]; then
    echo "${0}: DOTFILES_HOME environment variable has not been set." >&2
    exit 1
  fi
}

check_internet() {
  echo "${0}: Checking internet connection..."
  if ! wget -q --spider https://google.com; then
    echo "${0}: no internet connection" >&2
    exit 1
  fi
}

update_system() {
  printf '%s' "${0}: Update system? [y/n] " && read -r ans
  [ "${ans}" = 'y' ] && \
    sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get autoremove -y
}

install_packages() {
  echo "${0}: Installing apt-get packages..."
  for package in  \
    'mlocate'     \
    'ripgrep'     \
    'tree'        \
    'xclip'
  do
    dpkg "${package}" >/dev/null || sudo apt-get install -y "${package}"
  done

  command -v 'alacritty' >/dev/null || install_alacritty
  command -v 'bat'       >/dev/null || install_bat
  command -v 'exa'       >/dev/null || install_exa
  command -v 'nvim'      >/dev/null || install_neovim
  command -v 'zsh'       >/dev/null || install_zsh
}

install_alacritty() {
  echo "${0}: Installing alacritty..."
  link='https://github.com/alacritty/alacritty/releases/download/v0.4.3'
  deb='Alacritty-v0.4.3-ubuntu_18_04_amd64.deb'
  wget "${link}/${deb}" && sudo dpkg -i "${deb}" && rm "${deb}"
  sudo update-alternatives \
      --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
}

install_bat() {
  echo "${0}: Installing bat..."
  sudo apt-get install -y bat && \
  ln -s /usr/bin/batcat "${HOME}/.local/bin/bat"
}

install_exa() {
  command -v 'cargo' >/dev/null || sudo apt-get install -y cargo
  sudo cargo install exa
}

install_neovim() {
  echo "${0}: Installing neovim..."
  sudo add-apt-repository ppa:neovim-ppa/stable   && \
  sudo apt-get update                             && \
  sudo apt-get install -y neovim python3-neovim   && \
  sudo pip3 install pynvim
}

install_zsh() {
  echo "${0}: Installing zsh..."
  sudo apt-get install -y zsh fonts-powerline && \
  sudo chsh -s "$(which zsh)"
}

create_dirs() {
  echo "${0}: Creating cache directories..."
  mkdir -p "${HOME}"/.local/bin
  for prog in 'bash' 'python' 'zsh'; do
    [ -d "${XDG_CACHE_HOME}"/"${prog}" ] || mkdir -p "${XDG_CACHE_HOME}"/"${prog}"
  done
}

create_symlinks() {
  echo "${0}: Creating dotfiles symlinks..."

  ln -sf "${DOTFILES_HOME}"/bash/bashrc  "${HOME}"/.bashrc
  ln -sf "${DOTFILES_HOME}"/user-dirs.dirs "${XDG_CONFIG_HOME}"/user-dirs.dirs
  ln -sf "${DOTFILES_HOME}/vscode/settings.json" "${XDG_CONFIG_HOME}/Code/User/settings.json"

  for file in '.profile' '.xprofile'; do
    ln -sf "${DOTFILES_HOME}/${file}" "${HOME}/${file}"
  done

  for dir in 'alacritty' 'git' 'nvim' 'python' 'tmux' 'zsh'; do
    symlink_dir "${DOTFILES_HOME}/${dir}" "${XDG_CONFIG_HOME}/${dir}"
  done
}

symlink_dir() {
  [ -d "${2}" ] && rm -r "${2}"
  ln -sf "${1}" "${2}"
}

create_dir_if_not_exists() {
  [ -d "${1}" ] || mkdir -p "${1}"
}

main
