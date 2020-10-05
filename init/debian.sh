#!/bin/sh

# File:     debian.sh
# Created:  26.03.2020
# Author:   Artyom Danilov (@defytheflow)

update_system() {
  log 'Updating debian system.'

  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get autoremove -y
}

install_packages() {
  log 'Installing debian packages.'

  install_alacritty() {
    log "Checking that $(color alacritty) exists."

    if ! command -v alacritty >/dev/null; then
      link=https://github.com/alacritty/alacritty/releases/download/v0.4.3
      deb=Alacritty-v0.4.3-ubuntu_18_04_amd64.deb
      wget "${link}/${deb}" && sudo dpkg -i "${deb}" && rm "${deb}"
      sudo update-alternatives \
        --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
    fi
  }

  install_bat() {
    log "Checking that $(color bat) exists."

    if ! command -v bat >/dev/null; then
      link=https://github.com/sharkdp/bat/releases/download/v0.15.4
      deb=bat_0.15.4_amd64.deb
      wget "${link}/${deb}" && sudo dpkg -i "${deb}" && rm "${deb}"
    fi
  }

  install_neovim() {
    log "Checking that $(color neovim) exists."

    if ! command -v nvim >/dev/null; then
      sudo add-apt-repository -y ppa:neovim-ppa/stable
      sudo apt-get update
      sudo apt-get install -y neovim python3-neovim
    fi
  }

  install_zsh() {
    log "Checking that $(color zsh) exists."

    if ! command -v zsh >/dev/null; then
      sudo apt-get install -y zsh fonts-powerline
      sudo chsh -s "$(command -v zsh)"
      compaudit | xargs chown -R "$(whoami)" # insecure directories bug.
      compaudit | xargs chmod go-w
    fi
  }

  install_shfmt() {
    log "Checking that $(color shfmt) exists."

    if ! command -v shfmt >/dev/null; then
      vers=v3.1.2
      bin=shfmt_${vers}_linux_amd64
      wget https://github.com/mvdan/sh/releases/download/${vers}/${bin}
      sudo chmod -v +x ${bin}
      sudo mv -v ${bin} /usr/local/bin/shfmt
    fi
  }

  [ -z "${WSL_DISTRO_NAME}" ] && install_alacritty
  install_bat
  install_neovim
  install_zsh
  install_shfmt

  set -- \
    cargo clang \
    gdb \
    jq \
    mlocate \
    nitrogen npm \
    python3-pip \
    ripgrep \
    shellcheck \
    tmux tree \
    unzip \
    valgrind \
    xclip

  for pack; do
    log "Checking that $(color "${pack}") exists."
    package_exists "${pack}" || sudo apt-get install -y "${pack}"
  done
}

package_exists() {
  sudo dpkg -l "${1}" >/dev/null 2>&1 && sudo dpkg -S "${1}" >/dev/null 2>&1
}
