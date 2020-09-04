#!/bin/zsh

# File:     .zshrc
# Created:  22.03.2020
# Author:   Artyom Danilov (@defytheflow)


ZSH_CACHE="${XDG_CACHE_HOME}/zsh"

# don't type cd.
setopt autocd autopushd

# ls directory after cd.
chpwd() {
  emulate -L zsh
  ls -vh --color=auto --group-directories-first
}

# history {{{
export HISTFILE="${ZSH_CACHE}/history"
export HISTSIZE=10000
export SAVEHIST=10000
bindkey '^R' history-incremental-pattern-search-backward
#}}}

# completion {{{
autoload -Uz compinit
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' \
  'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # case insensitivity.
compinit -d "${ZSH_CACHE}/zcompdump-${ZSH_VERSION}"
_comp_options+=(globdots) # include hidden files.
#}}}

# vi-mode {{{

# enable {{{
bindkey -v
bindkey -v '^?' backward-delete-char # use backspace after vi-mode.
export KEYTIMEOUT=1 # faster enter normal mode.
#}}}

# edit-line {{{
autoload edit-command-line && zle -N edit-command-line && bindkey '^v' edit-command-line
autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line
#}}}

# cursor-shape {{{
zle-keymap-select() {
  if [ $KEYMAP = vicmd ] || [ $1 = 'block' ]; then
    echo -ne '\e[1 q'
  elif [ $KEYMAP = main ] || [ $KEYMAP = viins ] || [ $KEYMAP = '' ] || [ $1 = 'beam' ]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
  zle -K viins
  echo -ne '\e[5 q'
}
zle -N zle-line-init
#}}}

# ci", ci', ci`, di", etc {{{
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done
#}}}

# ci{, ci(, ci<, di{, etc {{{
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done
#}}}

# completion-menu {{{
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
#}}}

#}}}

# configs {{{
for file in "${DOTFILES_HOME}"/shell/*; do . "${file}"; done
[ -f "${ZDOTDIR}"/.zshprompt ] && . "${ZDOTDIR}"/.zshprompt
#}}}

# plugins {{{
[ -d "${ZPLUG_HOME}" ] || git clone https://github.com/zplug/zplug "${ZPLUG_HOME}"
. "${ZPLUG_HOME}"/init.zsh && zplug update >/dev/null

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "djui/alias-tips"
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

zplug check || zplug install
zplug load
#}}}

# should be last.
command -v pyenv 1>/dev/null 2>&1 && eval "$(pyenv init -)"
