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
autoload -Uz vcs_info # enable version control information.

# Taken from night-owl.vim
NIGHT_OWL_GREEN=149
NIGHT_OWL_CYAN=116
NIGHT_OWL_GOLD=221

# This color looks good with 'Night Owl' theme in vscode and vim.
# The previous purple color was 213.
NIGHT_OWL_PURPLE=140
GREEN=2
ORANGE=214
RED=202

# %s - displays the current version control system, like 'git' or 'svn'.
# %b - displays branch.
# %c - displays S if repository has staged changes.
# %u - displays U if repository ahs unstaged changes.
# %a - displays current action, like 'rebase' or 'merge'.
# %m - displays information about stashes in case of git.

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats " %s(%F{$NIGHT_OWL_GREEN}%b%c%u%f)%m"
zstyle ':vcs_info:git:*' actionformats " %s(%F{$NIGHT_OWL_GREEN}%b|%a%c%u%f)%m"
zstyle ':vcs_info:git:*' check-for-changes true # enable to use %c and %u sequences.
zstyle ':vcs_info:git:*' stagedstr "%F{$GREEN}*"
zstyle ':vcs_info:git:*' unstagedstr "%F{$ORANGE}*"
zstyle ':vcs_info:*+*:*' debug false
zstyle ':vcs_info:git*+set-message:*' hooks git-status git-untracked

function +vi-git-commit-count() {
  count=$(git rev-list --count ${hook_com[branch]})
  hook_com[misc]+="(${count})"
}

# from: https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
function +vi-git-status() {
  local -a gitstatus ahead_and_behind

  # if upstream exists
  if git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1; then
    arrow_color=${NIGHT_OWL_CYAN}
    ahead_and_behind=(
      $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
    )
  else
    arrow_color=${NIGHT_OWL_GOLD}
    for base_branch in develop main master; do
      # if branch exists
      if git rev-parse --quiet --verify $base_branch >/dev/null; then
        ahead_and_behind=(
          $(git rev-list --left-right --count HEAD...${base_branch} 2>/dev/null)
        )
        break
      fi
    done
  fi

  ahead=${ahead_and_behind[1]}
  behind=${ahead_and_behind[2]}

  ((( $ahead )) || (( $behind ))) && gitstatus+=( "[" )
  (( $behind )) && gitstatus+=( "%B%F{$arrow_color}↓${behind}%f%b" )
  (( $ahead )) && (( $behind )) && gitstatus+=( "/" )
  (( $ahead )) && gitstatus+=( "%B%F{$arrow_color}↑${ahead}%f%b" )
  ((( $ahead )) || (( $behind ))) && gitstatus+=( "]" )

  # %F{N} - enables N color.
  # %f - resets color.
  # %B - enables bold.
  # %b - disables bold.

  # (j::) - removes whitespaces between parts.
  hook_com[misc]+=${(j::)gitstatus}
}

# from: https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
function +vi-git-untracked(){
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep -q '^?? ' 2> /dev/null ; then
    hook_com[unstaged]+="%F{$RED}*"
  fi
}

precmd() { vcs_info }

# Enable prompt substitution.
setopt prompt_subst

function random_element {
  declare -a array=("$@")
  r=$((RANDOM % ${#array[@]}))
  printf "%s\n" "${array[$r]}"
}


emojis=(
  # Smileys & People.
  😅 😄 😎 😇 🥳 🤩 🤯 🤠 😼 🙂 🤔 🤨 😑 🤢 🥵 😵 🥺 😱 😣 😈 👻 🤖 👽 👾
  💪 🤘 👀
  🦸‍ 🧞‍ 🧙‍ 👨‍ 🏄‍♂️ 🔬

  # Food.
  🍰

  # Activity.
  🎧 🧸

  # Travel.
  🚀 🏎  🗿

  # Animals & Nature.
  🦁 🐯 🐶 🐵 🐻 🦊 🐱 🐭 🐰 🐻 🐻‍❄️  🐨 🐼 🐙 🐺 🦄 🦉
  🦢 🦤  🦜 🐩 🦎 🦖 🦕 🦍 🦧 🐊 🦂 🐍 🐢 🐘 🐉 🐿  🐑 🐪 🦈 🐠 🐳 🐬 🐡 🐝 🦀 🦑
  🌹 🌻 🌷 🦚 🌲 🌴 🌵 ✨ 💥 💫 ⭐  ⚡ ❄️ 🔥 ⛄ 🌊 🌧️

  # Objects.
  🎉 🧬 🔮 🎊 🔭 🎁 💎 💿

  # Symbols.
  💯 ⚛️  🔱 ⚪️
)
EMOJI=$(random_element $emojis)
PROMPT='%B%F{$NIGHT_OWL_PURPLE}%~%f%b${vcs_info_msg_0_} ${EMOJI} $ '
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
