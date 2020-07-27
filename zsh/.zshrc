#!/bin/zsh

# File:      .zshrc
# Created:   22.03.2020
# Author:    Artyom Danilov


# history.
export HISTFILE="${XDG_CACHE_HOME}"/zsh/history
export HISTSIZE=10000  # lines to store during interactive session.
export SAVEHIST=10000  # lines to save after interactive session.

# options.
setopt autocd autopushd  # don't type cd to change directories.

# called evety time directory is changed.
function chpwd() {
    emulate -L zsh
    ls -vh -F --group-directories-first
}

# autocompletion.
autoload -Uz compinit      # mark 'compinit' as function.
zmodload zsh/complist      # load this module to enhance completion features.
_comp_options+=(globdots)  # include hidden files in autocomplete.

zstyle ':completion:*' menu select  # do menu-driven completion.
compinit -d "${XDG_CACHE_HOME}"/zsh/zcompdump-"${ZSH_VERSION}"  # initialize completion.

# vim mode.
bindkey -v  # enable vim bindings.

# use vim keys in tab complete menu.
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# fix bug when you can't backspace after being in vim mode.
bindkey -v '^?' backward-delete-char
export KEYTIMEOUT=1  # faster enter normal mode.

# load aliases and functions, that can be used in any posix shell.
for file in "${DOTFILES_HOME}"/shell/*; do
    . "${file}"
done

# install zplug if not installed.
[ -d "${ZPLUG_HOME}" ] || git clone https://github.com/zplug/zplug "${ZPLUG_HOME}"

# essential.
. "${ZPLUG_HOME}"/init.zsh && zplug update >/dev/null

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "djui/alias-tips"
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

zplug check || zplug install  # install packages that have not been installed yet.
zplug load  # load plugins.

[ -f "${ZDOTDIR}"/.zshprompt ] && . "${ZDOTDIR}"/.zshprompt  # load prompt.

# load virtualenvwrapper (must be source last).
[ -f "${HOME}"/.local/bin/virtualenvwrapper.sh ] && . "${HOME}"/.local/bin/virtualenvwrapper.sh
