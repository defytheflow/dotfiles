#!/bin/zsh

# File:     .zshrc
# Created:  22.03.2020
# Author:   Artyom Danilov (@defytheflow)

[[ -f "${HOME}/.zprofile" ]] && source "${HOME}/.zprofile"

ZSH_CACHE="${HOME}/.cache/zsh"

# plugins {{{
export ZPLUG_HOME="${HOME}/.config/zplug"
export ZPLUG_CACHE_DIR="${HOME}/.cache/zplug"

[[ -d "${ZPLUG_HOME}" ]] || git clone https://github.com/zplug/zplug "${ZPLUG_HOME}"
source "${ZPLUG_HOME}/init.zsh"

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'plugins/command-not-found', from:oh-my-zsh
zplug 'plugins/fzf', from:oh-my-zsh
zplug 'kutsan/zsh-system-clipboard'

# autosuggestions.
zplug 'zsh-users/zsh-autosuggestions'
bindkey '^F' autosuggest-accept

# vim-mode.
zplug 'softmoth/zsh-vim-mode', defer:2
VIM_MODE_TRACK_KEYMAP=no
MODE_INDICATOR=
export KEYTIMEOUT=1

# z.
zplug 'agkozak/zsh-z'
export ZSHZ_DATA="${HOME}/.cache/z"

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
  add-zsh-hook -Uz chpwd (){ exa --group-directories-first; }
else
  case $OSTYPE in
  darwin*)
    add-zsh-hook -Uz chpwd (){ ls -vhG; }
    ;;
  linux*)
    add-zsh-hook -Uz chpwd (){ ls --color=auto -vh --group-directories-first; }
    ;;
  esac
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
function _set_block_cursor() { echo -ne '\e[1 q' }
function _set_beam_cursor() { echo -ne '\e[5 q' }
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    _set_block_cursor
  elif [ $KEYMAP = main ] || [ $KEYMAP = viins ] || [ $KEYMAP = '' ] || [ $1 = 'beam' ]; then
    _set_beam_cursor
  fi
}
zle -N zle-keymap-select
function zle-line-init() {
  zle -K viins
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
if [[ -n "${DOTFILES_HOME}" ]]; then
  for entry in "${DOTFILES_HOME}"/shell/*;do
    [[ -f ${entry} ]] && source "${entry}"
  done
fi
#}}}

# prompt {{{

# Enable version control information.
autoload -Uz vcs_info

# Taken from night-owl.vim
NIGHT_OWL_GREEN=149
NIGHT_OWL_CYAN=116

# This color looks good with 'Night Owl' theme in vscode and vim.
# The previous purple color was 213.
NIGHT_OWL_PURPLE=140

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats ' %s(%F{$NIGHT_OWL_GREEN}%b%f)%m'

# %b - displays branch.
# %s - displays 'git' or 'svn'
# %m - displays [↓N/↑N] when your local branch is behind or ahead-of remote HEAD (git).

# From: https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-st

function +vi-git-st() {
  local ahead behind
  local -a gitstatus

  # Exit early in case the worktree is on a detached HEAD
  git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

  local -a ahead_and_behind=(
    $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
  )

  ahead=${ahead_and_behind[1]}
  behind=${ahead_and_behind[2]}

  ((( $ahead )) || (( $behind ))) && gitstatus+=( "[" )
  (( $behind )) && gitstatus+=( "%B%F{$NIGHT_OWL_CYAN}↓${behind}%f%b" )
  (( $ahead )) && (( $behind )) && gitstatus+=( "/" )
  (( $ahead )) && gitstatus+=( "%B%F{$NIGHT_OWL_CYAN}↑${ahead}%f%b" )
  ((( $ahead )) || (( $behind ))) && gitstatus+=( "]" )

  # %F{N} - enables N color.
  # %f - resets color.
  # %B - enables bold.
  # %b - disables bold.

  # (j::) - removes whitespaces between parts.
  hook_com[misc]+=${(j::)gitstatus}
}

precmd() { vcs_info }

# Enable prompt substitution.
setopt prompt_subst

function random_element {
  declare -a array=("$@")
  r=$((RANDOM % ${#array[@]}))
  printf "%s\n" "${array[$r]}"
}

EMOJI="$(random_element 😅 👽 🔥 🚀 👻 ⛄ 👾 😄 🍰 🐑 😎 🏎 🤖 😇 😼 💪 🦄 🎉 💯 🐠 🐳 🐿 🥳 🤩 🤯 🤠 👨‍💻 🦸‍ 🧝‍ 🧞‍ 🧙‍ 👨‍🚀 👨‍🔬 🕺 🦁 🐶 🐵 🐻 🦊 🐙 🦎 🦖 🦕 🦍 🦈 🐊 🦂 🐍 🐢 🐘 🐉 🦚 ✨ 💥 💫 🧬 🔮 🎊 🔭 ⚪️ 🔱)"
export PROMPT='%B%F{$NIGHT_OWL_PURPLE}%~%f%b${vcs_info_msg_0_} ${EMOJI} $ '
#}}}

# default mac os zsh prompt with git branch information {{{
# This code is not supposed to run. I don't comment it out, so that syntax highlighting works.
if [ 0 != 0 ]; then
  # Enable version control information.
  autoload -Uz vcs_info

  # Taken from night-owl.vim
  NIGHT_OWL_GREEN=149

  zstyle ':vcs_info:*' enable git svn
  zstyle ':vcs_info:*' formats '%s(%F{$NIGHT_OWL_GREEN}%b%f) ' # with color.
  # zstyle ':vcs_info:*' formats '%s(%b) ' # without color.

  precmd() { vcs_info }

  # Enable prompt substitution.
  setopt prompt_subst

  export PROMPT='%n@%m %1~ ${vcs_info_msg_0_}%# '
fi
#}}}

# ocaml.
if command -v opam >/dev/null; then
  eval $(opam env)
fi

# haskell.
[ -f "${HOME}/.ghcup/env" ] && source "${HOME}/.ghcup/env"
