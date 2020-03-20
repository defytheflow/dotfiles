# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                   _
#                           _______| |__  _ __ ___
#                          |_  / __| '_ \| '__/ __|
#                           / /\__ \ | | | | | (__
#                          /___|___/_| |_|_|  \___|
#
# ----------------------------------------------------------------------------
# | File: .zshrc
# ----------------------------------------------------------------------------
# | Modified: March 20, 2020
# ----------------------------------------------------------------------------
# | Author: Artyom Danilov
# ----------------------------------------------------------------------------
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

echo 'Running ~/.zshrc'

# Path to your oh-my-zsh installation.
export ZSH='/home/defytheflow/.oh-my-zsh'

# ZSH_CUSTOM=/path/to/new-custom-folder

# ---------------------------------------------------------------------------- #
#                                    Theme                                     #
# ---------------------------------------------------------------------------- #

ZSH_THEME=''
#ZSH_THEME_RANDOM_CANDIDATES=()

# ---------------------------------------------------------------------------- #
#                                Shell Options                                 #
# ---------------------------------------------------------------------------- #

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE='true'

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS='true'

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE='true'

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION='true'

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# ---------------------------------------------------------------------------- #
#                                   Plugins                                    #
# ---------------------------------------------------------------------------- #

plugins=('colorize' 'git' 'man' 'vi-mode' 'zsh-syntax-highlighting')
# 'colorize' - ccat files with syntax highlight.
# 'man' - <Esc> + man previous command.
source $ZSH/oh-my-zsh.sh

# ---------------------------------------------------------------------------- #
#                    Aliases - Exports - functions - Prompt                    #
# ---------------------------------------------------------------------------- #

for file in 'aliases' 'exports' 'functions' 'prompt'; do
        [ -f "${HOME}/.${file}.sh" ] && . "${HOME}/.${file}.sh"
done

# ---------------------------------------------------------------------------- #
#                                     WSL                                      #
# ---------------------------------------------------------------------------- #

# If running on wsl:
if grep -qEi '(Microsoft|WSL)' /proc/version > /dev/null 2>&1; then
    [ -f "${HOME}/.wsl.sh" ] && . "${HOME}/.wsl.sh"
fi
