#!/usr/bin/env zsh

# File:     .zshenv
# Created:  30.03.2020
# Author:   Artyom Danilov (@defytheflow)

# To run commands installed with `brew`
export PATH="/opt/homebrew/bin:$PATH"

# To run my custom commands
export PATH="$HOME/.local/bin:$PATH"

# `node`
export NODE_REPL_HISTORY="$HOME/.cache/node_repl_history"

# `npm`
export NPM_CONFIG_CACHE="$HOME/.cache/npm"

# `zsh` history file
export HISTFILE="$HOME/.cache/zsh_history"

# `less` history file
export LESSHISTFILE="${HOME}/.cache/less/history"
