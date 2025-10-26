#!/usr/bin/env zsh
# vim: set foldmethod=marker:

# File:     .zshrc
# Created:  22.03.2020
# Author:   Artyom Danilov (@defytheflow)

[[ -f "${ZDOTDIR}/.zshenv" ]] && source "${ZDOTDIR}/.zshenv"

ZSH_CACHE="${HOME}/.cache/zsh"

# brew.
case $OSTYPE in
  darwin*)
    eval $(/opt/homebrew/bin/brew shellenv)
    ;;
esac

# plugins {{{
export ZPLUG_HOME="${HOME}/.config/zplug"
export ZPLUG_CACHE_DIR="${HOME}/.cache/zplug"

[[ -d "${ZPLUG_HOME}" ]] || git clone https://github.com/zplug/zplug "${ZPLUG_HOME}"
source "${ZPLUG_HOME}/init.zsh"

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
# zplug 'plugins/command-not-found', from:oh-my-zsh
zplug 'plugins/fzf', from:oh-my-zsh
zplug 'kutsan/zsh-system-clipboard'

zplug "zsh-users/zsh-history-substring-search"
bindkey '^[[A' history-substring-search-up # up arrow
bindkey '^[[B' history-substring-search-down # down arrow
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

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

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load # --verbose
#}}}

# options {{{
setopt autocd autopushd # don't type cd.
setopt interactive_comments # allow comments in interactive shells.
setopt menu_complete # auto-insert first possible completion.

# ls directory after cd.
autoload -U add-zsh-hook
if command -v exa >/dev/null; then
  add-zsh-hook -Uz chpwd (){ exa -F; }
else
  case $OSTYPE in
  darwin*)
    add-zsh-hook -Uz chpwd (){ ls -hF --color=auto; }
    ;;
  linux*)
    add-zsh-hook -Uz chpwd (){ ls -vhF --color=auto; }
    ;;
  esac
fi
#}}}

# history {{{
# By default prints only 15 last entries (https://stackoverflow.com/a/26848769)
alias history='history 1'

HISTSIZE=1000
SAVEHIST=1000

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
function zle-keymap-select() {
  if [[ $KEYMAP == vicmd ]] || [[ $1 = 'block' ]]; then
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
# This red looks/feels like zsh syntax plugin's red.
RED=203
GREY=250
DARK_LAVAND_PURPLE=146

# Replacements:
# %s - displays the current version control system (git, svn, etc.).
# %b - displays current branch.
# %a - displays current action (rebase' or merge).
# %c - displays string from `stagedstr` style if repository has staged changes.
# %u - displays string from `unstagedstr` style if repository has unstaged changes.
# %m - a misc replacement, backend decides what this replacement expands to.

zstyle ':vcs_info:*' enable git
#                                                      branch bold escape
#                                                           v v
zstyle ':vcs_info:git:*' formats " %s(%B%F{$NIGHT_OWL_GREEN}%b%%b%c%u%f%m)"
zstyle ':vcs_info:git:*' actionformats " %s(%F{$NIGHT_OWL_GREEN}%b|%a%c%u%f%m)"
zstyle ':vcs_info:git:*' check-for-changes false # enable to use %c and %u sequences.
zstyle ':vcs_info:git:*' stagedstr "%F{$GREEN}*"
zstyle ':vcs_info:git:*' unstagedstr "%F{$ORANGE}*"
zstyle ':vcs_info:*+*:*' debug false
# zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-stash git-remotebranch git-status
zstyle ':vcs_info:git*+set-message:*' hooks git-stash git-remotebranch git-status git-commit-count

GIT_CONFIG_USER_NAME=$(git config --global user.name)

function +vi-git-commit-count() {
  # `refs/heads/` prefix before hook_com[branch] is needed in case branch has the same name as
  # a file or folder inside the current directory and git is confused what we want: branch or file,
  # this prefix makes sure git treats it as a branch name
  count=$(git rev-list --count --author="$GIT_CONFIG_USER_NAME" refs/heads/${hook_com[branch]} 2>/dev/null || echo 0)
  count_today=$(git rev-list --count --author="$GIT_CONFIG_USER_NAME" --since="$(date +%Y-%m-%d)T00:00:00" refs/heads/${hook_com[branch]})
  hook_com[misc]+="%B%F{$DARK_LAVAND_PURPLE}[${count_today}/${count}]%f%b"
}

# Compare local changes to remote changes
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

  if (( $ahead )) || (( $behind )); then
    gitstatus+=( "[" )
  fi
  if (( $behind )); then
    gitstatus+=( "%B%F{$arrow_color}↓${behind}%f%b" )
  fi
  if (( $ahead )) && (( $behind )); then
    gitstatus+=( "/" )
  fi
  if (( $ahead )); then
    gitstatus+=( "%B%F{$arrow_color}↑${ahead}%f%b" )
  fi
  if (( $ahead )) || (( $behind )); then
    gitstatus+=( "]" )
  fi

  # %F{N} - enables N color.
  # %f - resets color.
  # %B - enables bold.
  # %b - disables bold.

  # (j::) - removes whitespaces between parts.
  hook_com[misc]+=${(j::)gitstatus}
}

# Display the existence of files not yet known to git
# from: https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
function +vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep -q '^?? ' 2> /dev/null ; then
    hook_com[unstaged]+="%F{$RED}*"
  fi
}

# Show remote branch name for remote-tracking branches
# from: https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
function +vi-git-remotebranch() {
  local remote

  # Are we on a remote-tracking branch?
  remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
      --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

  # The first test will show a tracking branch whenever there is one. The
  # second test, however, will only show the remote branch's name if it
  # differs from the local one.
  if [[ -n ${remote} ]] ; then
  #if [[ -n ${remote} && ${remote#*/} != ${hook_com[branch]} ]] ; then
      hook_com[misc]="${hook_com[misc]}${reset_color}->%B%F{$GREY}${remote}${reset_color}"
  fi
}

function +vi-git-stash() {
  count=$(git stash list 2>/dev/null | wc -l)
  count=${count##*(  )} # removes leading whitespace

  if [ $count -gt 0 ]; then
    hook_com[misc]+="@{$count}"
  fi
}

precmd() { vcs_info }

# Allows to include commands and variables in the shell prompt.
setopt prompt_subst

function random_element() {
  declare -a array=("$@")
  r=$((RANDOM % ${#array[@]}))
  printf "%s\n" "${array[$r]}"
}

# These emojis need an extra space in iterm, but don't need it in built-in terminal app
inconsistent_display_emojis=('🥸 ' '🥲 ' '🤌 ' '🦫 ' '🦤 ' '🦭 ' '🛖 ' '🪄 ')
# Some emojis have two spaces between them. This is intentional, otherwise they will be
# displayed too close in terminal neovim.
# Some emojis are wrapped in single quotes and have an extra space. Those emojis for
# whatever reason are displayed right next to the '$' sign without it.
emojis=(
  # Smileys & People.
  😅 😄 😎 😇 🥳 🤩 😵‍💫 🤯 🤠 😂 😊 😍 🙂 🤔 🤨 😑 🤢 🥵 🥶 😵 😌 🥺 😱 😣
  😋 😶‍🌫️  🙄 😴 😕 😭 😰
  🤬 😈 💀 👻 🤖 👽 👾 😸 😼 😻 👌 👍 🤘 💪 👀
  🤷‍♀️ 🧑‍💻 🧑‍🎤 🦸‍ 🦹 🧙‍ 🧝‍♀️ 🧞‍ 🧟 '☂️ ' 🎃 👘 👑
  # Animals & Nature.
  🦁 🐯 🐶 🐵 🐻 🦊 🐱 🐭 🐰 🐻 🐻‍❄️ 🐨 🐼 🐙 🐺 🦄 🦉
  🦘 🦔 🐅 🦌 🦆 🦢 🦜 🐩 🦎 🦖 🦕 🦍 🦧 🐊 🦂 🐍 🐢 🐘 🐉 '🐿 '  🐑 🐪 🦈 🐠 🐳 🐬 🐡 🐝 🦀 🦑
  🌸 🌼 🌹 🌻 🌷 🦚 🌲 🌴 🌵 🍁 🌍 ✨ 💥 💫 ⭐ '❄️ ' 🔥 🎄 ⛄ 🌊 '🌧 '
  # Food & Drink.
  🍇 🍉 🍊 🍋 🍌 🍎 🍍 🍑 🍒 🍓 🥝 🥥 🥑 🥐 🍔 🍕 🥚 🍿 🍩 🍪 🎂 🍰 🥧 🍬 🍭 🍷 🍹 🥤 🧊
  # Activity.
  🏄‍♂️ 🏂 🏆 🏀 🥊 🎣 🧩 🎲 🎨 🎭 🎧 🎸 🎻 🎹 🥁 🎬
  # Travel & Places.
  🌋 🗻 '🏕️ ' '🏝️ ' 🏠 🌃 🌆 🎡 🚂 🚃 '🏎 ' ⛵ '✈️ ' 🚁 🚀 🛸 🪐 '⛱️ '  🎇 🗿 '❄️ '
  # Objects.
  💌 💣 🧭 🎈 🎉 🎊 🎏 🧧 🎀 🎁 🔮 💎 💻 💿 🔍 '🕯️ ' 💡 📚 💰 '✏️ ' '🖍️ ' 🔒 🔑 🪓 🔫 🧲 🧬 🔭 🧸
  # Symbols.
  💯 💤 🃏 '⚛️ ' 🔱 ⚪️
)

_time_='[%D{%H:%M}]'
# figure out how to not display anything if at home directory and otherwise display full path
#                            %1~
_pwd_="%B%F{$NIGHT_OWL_PURPLE}%~%f%b"
_emoji_=$(random_element $emojis)
_jobs_='%(1j.[%j] .)'
GREYISH_WHITE=252
NEWLINE=$'\n'
# don't use a custom color for >, because it doesn't adjust to the terminal's colorscheme.
_char_="${NEWLINE}%B%(?.%F{$GREYISH_WHITE}>%f.%F{$RED}>%f)%b"
_short_prompt_='${_emoji_} ${_jobs_}${_char_} '
# don't use ${_short_prompt_} inside _long_prompt_ because emoji() function will not work
_long_prompt_='${_time_} ${_pwd_}${vcs_info_msg_0_} ${_emoji_} ${_jobs_}${_char_} '

PROMPT=$_long_prompt_
function short() { PROMPT=$_short_prompt_ }
function long() { PROMPT=$_long_prompt_ }
# tried to write a solution with a while loop to avoid the same emojis, couldn't get it to work,
# always got stuck in an infinite loop.
function emoji() { _emoji_=$(random_element $emojis) }
function properoomify() { _emoji_="🐝 " }

# EXIT_CODE="%(?..%F{$RED}[%?]%f)"
# EXIT_CODE="%(?.%F{$NIGHT_OWL_GREEN}:)%f.%F{$RED}:(%f)"

# Uncomment to debug emojis display with '$' sign.
# for emoji in $emojis; do echo "${emoji} $ "; done
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
command -v opam >/dev/null && eval $(opam env)

# opam configuration (ocaml).
[[ ! -r "${HOME}/.opam/opam-init/init.zsh" ]] || source "${HOME}/.opam/opam-init/init.zsh"

# haskell.
[[ -f "${HOME}/.ghcup/env" ]] && source "${HOME}/.ghcup/env"

# bun completions
[[ -s "${HOME}/.bun/_bun" ]] && source "${HOME}/.bun/_bun"

# bun
export BUN_INSTALL="${HOME}/.bun"
export PATH="${BUN_INSTALL}/bin:${PATH}"

# pnpm
export PNPM_HOME="${HOME}/.local/share/pnpm"
export PATH="${PNPM_HOME}:${PATH}"

# go
export PATH="/usr/local/go/bin:${PATH}"

# rust
export PATH="${PATH}:${HOME}/.config/cargo/bin"

# command not found
# HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
# [[ -f "$HB_CNF_HANDLER" ]] && source "$HB_CNF_HANDLER";

# command -v fortune >/dev/null && fortune
# command -v title >/dev/null && title "Rest at the end, not in the middle."
