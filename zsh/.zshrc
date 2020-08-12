#!/bin/zsh

# File:     .zshrc
# Created:  22.03.2020
# Author:   Artyom Danilov (@defytheflow)


ZSH_CACHE="${XDG_CACHE_HOME}/zsh"

# history
export HISTFILE="${ZSH_CACHE}/history"
export HISTSIZE=10000                 # lines to store during session.
export SAVEHIST=10000                 # lines to save after session.

# don't type cd to change directories.
setopt autocd autopushd

# called every time directory is changed.
function chpwd() {
    emulate -L zsh
    ls -vh --color=auto --group-directories-first
}

# load completion modules.
autoload -Uz compinit
zmodload zsh/complist

# include hidden files in autocompletion.
_comp_options+=(globdots)

# do menu-driven completion.
zstyle ':completion:*' menu select

# initalize completion.
compinit -d "${ZSH_CACHE}/zcompdump-${ZSH_VERSION}"

# enable vi-mode.
bindkey -v
bindkey -v '^?' backward-delete-char  # to use backspace after vi-mode.
export KEYTIMEOUT=1                   # to faster enter normal mode.

# change cursor shape in normal and insert modes.
zle-keymap-select () {
    if [ $KEYMAP = vicmd ]; then
        printf '\033[2 q'
    else
        printf '\033[6 q'
    fi
}
zle-line-init () {
    zle -K viins
    printf '\033[6 q'
}
zle -N zle-keymap-select
zle -N zle-line-init

# tab completion menu.
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# source shell-independent files (aliases, functions).
for file in "${DOTFILES_HOME}"/shell/*; do . "${file}"; done

# install zplug.
[ -d "${ZPLUG_HOME}" ] || git clone https://github.com/zplug/zplug "${ZPLUG_HOME}"

# source zplug.
. "${ZPLUG_HOME}"/init.zsh && zplug update >/dev/null

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "djui/alias-tips"
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

# install packages.
zplug check || zplug install

# load plugins.
zplug load

# load prompt configuration.
[ -f "${ZDOTDIR}"/.zshprompt ] && . "${ZDOTDIR}"/.zshprompt

# init pyenv.
command -v pyenv 1>/dev/null 2>&1 && eval "$(pyenv init -)"
