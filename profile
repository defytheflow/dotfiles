#!/bin/sh

# File:      .profile
# Purpose:   define important environment variables.
# Created:   28.03.2020
# Modified:  28.03.2020
# Author:    Artyom Danilov


# XDG Base Directory
export XDG_CACHE_HOME="${HOME}"/.cache
export XDG_CONFIG_HOME="${HOME}"/.config
export XDG_DATA_HOME="${HOME}"/.local/share

# Where your dotfiles reside
export DOTFILES_HOME="${HOME}"/.dotfiles
