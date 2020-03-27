#!/bin/sh

init_zsh_plugins() {

    [ ! -d "${ZSH_PLUGINS}" ] && mkdir "${ZSH_PLUGINS}"

    [ ! -d "${ZSH_PLUGINS}"/zsh-syntax-highlighting ] && \
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "${ZSH_PLUGINS}"/zsh-syntax-highlighting

    [ ! -d "${ZSH_PLUGINS}"/zsh-autosuggestions ] && \
        git clone https://github.com/zsh-users/zsh-autosuggestions \
        "${ZSH_PLUGINS}"/zsh-autosuggestions

    [ ! -d "${ZSH_PLUGINS}"/alias-tips ] && \
        git clone https://github.com/djui/alias-tips.git \
        "${ZSH_PLUGINS}"/alias-tips

    [ ! -d "${ZSH_PLUGINS}"/command-not-found ] && \
        mkdir "${ZSH_PLUGINS}"/command-not-found && \
        url="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master" && \
        url="${url}/plugins/command-not-found/command-not-found.plugin.zsh" && \
        wget -P "${ZSH_PLUGINS}"/command-not-found "${url}"
}

init_dotfiles() {

    backup_dir="${HOME}/.config/dotfiles/backup"

    [ ! -d "${backup_dir}" ] &&  mkdir -p "${backup_dir}"

    # Backup old dotfiles.
    for dotfile in '.bashrc' '.pythonrc' '.tmux.conf' '.vimrc' '.zshrc'; do
        [ -f "${HOME}/${dotfile}" ] && mv "${HOME}/${dotfile}" "${backup_dir}"
    done

    [ -f "${HOME}/.config/git/config" ] &&
        mv "${HOME}/.config/git/config" "${backup_dir}"

    # Symlink new dotfiles.
    ln -s "${HOME}/.dotfiles/bash/bashrc"     "${HOME}/.bashrc"
    ln -s "${HOME}/.dotfiles/python/pythonrc" "${HOME}/.pythonrc"
    ln -s "${HOME}/.dotfiles/tmux/config"     "${HOME}/.tmux.conf"
    ln -s "${HOME}/.dotfiles/vim/vimrc"       "${HOME}/.vimrc"
    ln -s "${HOME}/.dotfiles/zsh/zshrc"       "${HOME}/.zshrc"
    ln -s "${HOME}/.dotfiles/git/config"      "${HOME}/.config/git/config"
}

init_dotfiles
[ "${SHELL}" = /usr/bin/zsh ] && init_zsh_plugins
exit 0
