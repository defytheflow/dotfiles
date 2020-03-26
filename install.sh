#!/bin/sh

# Create zsh-plugins folder.
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
