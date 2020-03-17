#!/bin/bash

# -----------------------------------------------------------------------------
#                             _ _
#                        __ _| (_) __ _ ___  ___  ___
#                       / _` | | |/ _` / __|/ _ \/ __|
#                      | (_| | | | (_| \__ \  __/\__ \
#                       \__,_|_|_|\__,_|___/\___||___/
#
# -----------------------------------------------------------------------------
#  File: .bash_aliases
# -----------------------------------------------------------------------------
#  Modified: March 17, 2020
# ---------------------------------------------------------------------------- 
#  Author: Artyom Danilov
# -----------------------------------------------------------------------------

# ---------------------------------------------------------------------------- #
#                                      cd                                      #
# ---------------------------------------------------------------------------- #

# Typing mistakes.
alias cd..='cd ..'
alias cd-=' cd -'
alias cd~=' cd ~'

# Faster movement.
alias ..='   cd ..'
alias ...='  cd ../../'
alias ....=' cd ../../../'
alias .....='cd ../../../../'

# ---------------------------------------------------------------------------- #
#                                    ls/dir                                    #
# ---------------------------------------------------------------------------- #

# Better ls. (-v is natural sort of numbers in names)
alias ls=' ls -v --classify --color=never --group-directories-first --human-readable'

# Fast typing.
alias l='  ls -1'               # list vertically
alias la=' ls --almost-all'     # list all
alias lh=' ls --directory .*'   # list hidden
alias ll=' ls -l'               # list long
alias lr=' ls --recursive'      # list recursively
alias lal='ls -l --almost-all'  # list all long

# Colorize output.
alias dir='dir   --color=auto'
alias vdir='vdir --color=auto'

# ---------------------------------------------------------------------------- #
#                                    clear                                     #
# ---------------------------------------------------------------------------- #

# For windows cmd users.
alias cls='clear'
alias clr='clear'

# ---------------------------------------------------------------------------- #
#                                     cat                                      #
# ---------------------------------------------------------------------------- #

# Fast typing.
alias ncat='cat --number'
alias tcat="cat --show-tabs"

# Colorful cat
alias lcat='lolcat'

# ---------------------------------------------------------------------------- #
#                                     grep                                     #
# ---------------------------------------------------------------------------- #

# Colorize output.
alias grep='  grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ---------------------------------------------------------------------------- #
#                                     diff                                     #
# ---------------------------------------------------------------------------- #

# Better diff.
alias diff='diff --side-by-side --suppress-common-lines'

# ---------------------------------------------------------------------------- #
#                                     vim                                      #
# ---------------------------------------------------------------------------- #

# Shorthand.
alias v='vim'

# Use vim instead of vi.
alias vi='vim'

# Edit system files.
alias svim='sudo vim'

# For windows cmd users.
alias edit='vim'

# ---------------------------------------------------------------------------- #
#                             cp/mv/rv/mkdir/rmdir                             #
# ---------------------------------------------------------------------------- #

# Better versions.
alias rm='rm --interactive=once --preserve-root --verbose'
alias mv='mv --interactive --verbose'
alias cp='cp --interactive --verbose'
alias mkdir='mkdir --parents --verbose'
alias rmdir='rmdir --parents --verbose'

# For system files.
alias scp='sudo cp'
alias smv='sudo mv'
alias srm='sudo rm'
alias smkdir='sudo mkdir'
alias srmdir='sudo rmdir'

# For windows cmd users.
alias copy='cp'
alias move='mv'
alias rename='mv'
alias del='rm'

# Shorthand.
alias mkd='mkdir'
alias rmd='rmdir'

# ---------------------------------------------------------------------------- #
#                                Right Version                                 #
# ---------------------------------------------------------------------------- #

alias pip='pip3'
alias pylint='pylint3'
alias python='python3'

# ---------------------------------------------------------------------------- #
#                                  Shorthands                                  #
# ---------------------------------------------------------------------------- #

alias f='file'
alias g='git'
alias h='history'
alias p='python3'
alias r='ranger'
alias t='tree'

alias gh='history | grep'
alias py='python3'
alias sc='shellcheck'

alias shu='shunit2'
alias rld="source ${HOME}/.bash_profile"

# ---------------------------------------------------------------------------- #
#                                 New Commands                                 #
# ---------------------------------------------------------------------------- #

alias now='date +\"%T\"'                     # prints current time
alias path="echo ${PATH} | sed -e 's/:/\n/g'"  # lists the path on new line

alias starwars='telnet towel.blinkenlights.nl'
alias update='sudo apt-get update;sudo apt-get upgrade;sudo apt-get autoremove'
alias weather='curl http://wttr.in/'

# ---------------------------------------------------------------------------- #
#                                    Other                                     #
# ---------------------------------------------------------------------------- #

# Browser
alias chrome='google-chrome'
alias browser='chrome'

# Require password.
alias reboot='sudo reboot'
alias shutdown='sudo shutdown'

# ---------------------------------------------------------------------------- #
#                                     End                                      #
# ---------------------------------------------------------------------------- #
