#!/bin/bash

#        _ _
#   __ _| (_) __ _ ___  ___  ___
#  / _` | | |/ _` / __|/ _ \/ __|
# | (_| | | | (_| \__ \  __/\__ \
#  \__,_|_|_|\__,_|___/\___||___/
#

# Author: Artyom Danilov
# Modified: March 13, 2020.

# --------------------------------------------------------------------------- #
#                                   cd                                        #
# --------------------------------------------------------------------------- #

# Typing mistakes
alias cd..="cd .."
alias cd-="cd -"

# Fast movement
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"

# --------------------------------------------------------------------------- #
#                                  ls/dir                                     #
# --------------------------------------------------------------------------- #

alias ls="ls -h -F --color=never --group-directories-first"

alias l="ls -1"       # list vertically
alias ll="ls -l"      # list long
alias la="ls -A"      # list all
alias lr="ls -R"      # list recursively
alias lh="ls -d .*"   # list hidden
alias lf="find -maxdepth 1 -type f -print0 | xargs -0r ls" # list files
alias lal="ls -l -A"  # list all long
alias ldir="ls -d */" # list directories

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# --------------------------------------------------------------------------- #
#                                   clear                                     #
# --------------------------------------------------------------------------- #

alias clr="clear"
alias cls="clear"

# --------------------------------------------------------------------------- #
#                                    cat                                      #
# --------------------------------------------------------------------------- #

alias ncat="cat -n"
alias tcat="cat -t"
alias lcat="lolcat"
# --------------------------------------------------------------------------- #
#                                   grep                                      #
# --------------------------------------------------------------------------- #

alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# --------------------------------------------------------------------------- #
#                                   diff                                      #
# --------------------------------------------------------------------------- #

alias diff="diff --side-by-side --suppress-common-lines"

# --------------------------------------------------------------------------- #
#                                    vim                                      #
# --------------------------------------------------------------------------- #

alias v="vim"
alias vi="vim"
alias svim="sudo vim"
alias edit="vim"

# --------------------------------------------------------------------------- #
#                            rm/mv/cp/rmdir/mkdir                             #
# --------------------------------------------------------------------------- #

# rm/mv/cp
alias rm="rm -Iv --preserve-root"; alias srm="sudo rm"; alias remove="rm"
alias mv="mv -iv";                 alias smv="sudo mv"; alias move="mv"
alias cp="cp -iv";                 alias scp="sudo cp"; alias copy="cp"

# mkdir/rmdir
alias mkdir="mkdir -pv"; alias mkd="mkdir"; alias smkd="sudo mkdir"
alias rmdir="rmdir -pv"; alias rmd="rmdir"; alias srmd="sudo rmdir"

alias del="rm -rfi"; alias delete="del"

# --------------------------------------------------------------------------- #
#                               Right Versions                                #
# --------------------------------------------------------------------------- #

alias pip="pip3"
alias pylint="pylint3"
alias python="python3"

# --------------------------------------------------------------------------- #
#                                Shorthands                                   #
# --------------------------------------------------------------------------- #

alias f="file"
alias g="git"
alias h="history"
alias p="python3"
alias r="ranger"
alias t="tree"

alias hg="history | grep"
alias py="python3"
alias sc="shellcheck"

alias shu="shunit2"
alias rld="source ~/.bashrc && echo Bash reloaded"; alias reload="rld"

alias chrome="google-chrome"; alias browser="chrome"
alias update="sudo apt-get update;sudo apt-get upgrade;sudo apt-get autoremove"

# --------------------------------------------------------------------------- #
#                                New commands                                 #
# --------------------------------------------------------------------------- #

alias now="date +\"%T\""                     # prints current time
alias path="echo $PATH | sed -e 's/:/\n/g'"  # lists the path on new line
alias weather="curl http://wttr.in/"
alias starwars="telnet towel.blinkenlights.nl"

# --------------------------------------------------------------------------- #
#                                Power Off                                    #
# --------------------------------------------------------------------------- #

alias reboot="sudo reboot"
alias shutdown="sudo shutdown"
