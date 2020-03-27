#!/bin/sh

init_zsh_plugins() {
# Download zsh plugins.
    zsh_plugins="${HOME}"/.dotfiles/zsh/plugins

    [ ! -d "${zsh_plugins}" ] && mkdir "${zsh_plugins}"

    [ ! -d "${zsh_plugins}"/zsh-syntax-highlighting ] && \
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "${zsh_plugins}"/zsh-syntax-highlighting

    [ ! -d "${zsh_plugins}"/zsh-autosuggestions ] && \
        git clone https://github.com/zsh-users/zsh-autosuggestions \
        "${zsh_plugins}"/zsh-autosuggestions

    [ ! -d "${zsh_plugins}"/alias-tips ] && \
        git clone https://github.com/djui/alias-tips.git \
        "${zsh_plugins}"/alias-tips

    [ ! -d "${zsh_plugins}"/command-not-found ] && \
        mkdir "${zsh_plugins}"/command-not-found && \
        url=https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master && \
        url="${url}"/plugins/command-not-found/command-not-found.plugin.zsh && \
        wget -P "${zsh_plugins}"/command-not-found "${url}"
}

init_dotfiles() {
# Create symlinks.
    backup_dir="${HOME}"/.config/dotfiles/backup

    [ ! -d "${backup_dir}" ] &&  mkdir -p "${backup_dir}"

    # Backup old dotfiles.
    for dotfile in '.bashrc' '.pythonrc' '.tmux.conf' '.vimrc' '.zshrc'; do
        [ -f "${HOME}/${dotfile}" ] && mv "${HOME}/${dotfile}" "${backup_dir}"
    done

    [ -f "${HOME}"/.config/git/config ] &&
        mv "${HOME}"/.config/git/config "${backup_dir}"

    # Symlink new dotfiles.
    ln -s "${HOME}"/.dotfiles/bash/bashrc     "${HOME}"/.bashrc
    ln -s "${HOME}"/.dotfiles/python/pythonrc "${HOME}"/.pythonrc
    ln -s "${HOME}"/.dotfiles/tmux/config     "${HOME}"/.tmux.conf
    ln -s "${HOME}"/.dotfiles/vim/vimrc       "${HOME}"/.vimrc
    ln -s "${HOME}"/.dotfiles/zsh/zshrc       "${HOME}"/.zshrc
    ln -s "${HOME}"/.dotfiles/git/config      "${HOME}"/.config/git/config
}

init_dotfiles
[ "${SHELL}" = /usr/bin/zsh ] && init_zsh_plugins
exit 0
