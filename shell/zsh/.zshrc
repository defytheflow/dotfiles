#!/bin/zsh

# File:     .zshrc
# Created:  22.03.2020
# Author:   Artyom Danilov (@defytheflow)

ZSH_CACHE="${HOME}/.cache/zsh"

# plugins {{{
export ZPLUG_HOME="${HOME}/.config/zplug"
export ZPLUG_CACHE_DIR="${HOME}/.cache/zplug"

[ -d "${ZPLUG_HOME}" ] || git clone https://github.com/zplug/zplug "${ZPLUG_HOME}"
source "${ZPLUG_HOME}/init.zsh"

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'plugins/command-not-found', from:oh-my-zsh
zplug 'kutsan/zsh-system-clipboard'

# autosuggestions {{{
zplug 'zsh-users/zsh-autosuggestions'
bindkey '^F' autosuggest-accept
#}}}

# vim-mode {{{
zplug 'softmoth/zsh-vim-mode', defer:2
VIM_MODE_TRACK_KEYMAP=no
MODE_INDICATOR=
#}}}

# z {{{
zplug 'agkozak/zsh-z'
export ZSHZ_DATA="${HOME}/.cache/z"
#}}}

zplug check || zplug install
zplug load
#}}}

# options {{{
setopt autocd autopushd # don't type cd.
setopt interactive_comments # allow comments in interactive shells.
setopt menu_complete # auto-insert first possible completion.

# ls directory after cd.
autoload -U add-zsh-hook
if command -v exa >/dev/null; then
    add-zsh-hook -Uz chpwd (){ exa --icons --group-directories-first; }
else
    add-zsh-hook -Uz chpwd (){ ls --color=auto -vh --group-directories-first; }
fi
#}}}

# history {{{
export HISTFILE="${ZSH_CACHE}/history"
export HISTSIZE=10000
export SAVEHIST=10000

setopt share_history # share history across shells.
setopt inc_append_history # commands added to history immediately.
setopt extended_history # record the timestamp of each command.
setopt hist_ignore_all_dups # do not write duplicate commands.

# Search history with <ctrl-r>.
bindkey '^R' history-incremental-pattern-search-backward
#}}}

# completion {{{
autoload -U compinit
compinit -d "${ZSH_CACHE}/zcompdump-${ZSH_VERSION}"

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''

# Enable keyboard navigation of completions in menu.
zstyle ':completion:*' menu select

# Accept case-insensitivity, abbreviations after . or _ or -, substrings.
zstyle ':completion:*' matcher-list '' \
  'm:{a-zA-Z}={A-Za-z}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Categorize completion suggestions with headings.
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B%--- %d ---%b%f
#}}}

# cursor {{{
zle-keymap-select() {
 # Change cursor shape in different modes.
  if [ $KEYMAP = vicmd ] || [ $1 = 'block' ]; then
    echo -ne '\e[1 q'
  elif [ $KEYMAP = main ] || [ $KEYMAP = viins ] || [ $KEYMAP = '' ] || [ $1 = 'beam' ]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
  zle -K viins
  # echo -ne '\e[5 q'
  echo -ne "\033]12;#00ff00\007"
}
zle -N zle-line-init
#}}}

# binds {{{
bindkey -v # vi-mode.
bindkey -v '^?' backward-delete-char # use backspace after vi-mode.

# Menu completion navigaton with hjkl.
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Edit line in vim with <ctrl-e>.
autoload edit-command-line && zle -N edit-command-line
bindkey '^e' edit-command-line
#}}}

# other {{{
if [ -n "${DOTFILES_HOME}" ]; then
  for file in "${DOTFILES_HOME}"/shell/*; do . "${file}"; done
fi
#}}}

export PROMPT='%B%F{213}%~%f%b $ '
