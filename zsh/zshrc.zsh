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
# | Modified: March 21, 2020
# ----------------------------------------------------------------------------
# | Author: Artyom Danilov
# ----------------------------------------------------------------------------
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

echo 'Running ~/.zshrc'

# ---------------------------------------------------------------------------- #
#                              Auto-tab complete                               #
# ---------------------------------------------------------------------------- #

autoload -U compinit
zstyle ':completion:*' menu select

# Include hidden files.
_comp_options+=(globdots)

# vi mode
bindkey -v

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# ---------------------------------------------------------------------------- #
#                    Aliases - Exports - functions - Prompt                    #
# ---------------------------------------------------------------------------- #

for file in 'aliases' 'exports' 'functions' 'prompt'; do
        [ -f "${HOME}/.dotfiles/${file}.sh" ] && . "${HOME}/.dotfiles/${file}.sh"
done

# ---------------------------------------------------------------------------- #
#                                     WSL                                      #
# ---------------------------------------------------------------------------- #

# If running on wsl:
if grep -qEi '(Microsoft|WSL)' /proc/version > /dev/null 2>&1; then
    [ -f "${HOME}/.dotfiles/wsl.sh" ] && . "${HOME}/.dotfiles/wsl.sh"
fi

# ---------------------------------------------------------------------------- #
#                                   Plugins                                    #
# ---------------------------------------------------------------------------- #

# Must be last.
source ~/.dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
