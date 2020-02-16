#        _ _
#   __ _| (_) __ _ ___  ___  ___
#  / _` | | |/ _` / __|/ _ \/ __|
# | (_| | | | (_| \__ \  __/\__ \
#  \__,_|_|_|\__,_|___/\___||___/
#
# Author: Artyom Danilov
# Last modification date: February 16, 2020.

# CD ----------------------------------
# Typing mistakes alias cd..="cd .."
alias cd-="cd -"

# Fast movement
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias .2="cd ../../"
alias .3="cd ../../../"
alias .4="cd ../../../../"
alias .5="cd ../../../../../"

# LS ----------------------------------
alias ls="ls -h -F --color=never --group-directories-first"
alias l=ls
alias ll="ls -l"      # list long
alias la="ls -A"      # list all
alias lr="ls -R"      # list recursively
alias lh="ls -d .*"   # list hidden
alias lf="find -maxdepth 1 -type f -print0 | xargs -0r ls" # list files
alias lal="ls -l -A"  # list all long
alias ldir="ls -d */" # list directories

# DIR ---------------------------------
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# CLEAR -------------------------------
alias clr=clear
alias cls=clear

# CAT ---------------------------------
alias ncat="cat -n"
alias tcat="cat -t"
alias lcat=lolcat

# GREP --------------------------------
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# VIM ---------------------------------
alias v=vim
alias vi=vim
alias svim="sudo vim"
alias edit=vim

# FILE MANIPULATION -------------------

# Protection
alias rm="rm -I --preserve-root"
alias mv="mv -i -v"        # interactive and vebose
alias cp="cp -i -v"


alias mkdir="mkdir -p -v"  # parent and verbose
alias rmdir="rmdir -p -v"

# Explicitness
alias copy=cp
alias move=mv
alias remove=rm

# POWER OFF ---------------------------
alias reboot="sudo reboot"
alias shutdown="sudo shutdown"

# BROWSER -----------------------------
alias chrome=google-chrome
alias browser=chrome

# RIGHT VERSIONS ----------------------
alias pip=pip3
alias pylint=pylint3
alias python=python3

# SHORTHANDS --------------------------
alias f=file
alias g=git
alias h=history
alias p=python3
alias py=python3
alias hs="history | grep"                    # history search
alias su=sudo

# NEW COMMANDS ------------------------
alias now="date +\"%T\""                     # prints current time
alias path="echo $PATH | sed -e 's/:/\n/g'"  # lists the path on new line
alias reload="source ~/.bashrc && echo Bash reloaded"
alias weather="curl http://wttr.in/"

# OTHER -------------------------------
alias update="sudo apt-get update;sudo apt-get upgrade;sudo apt-get autoremove"
alias cpuinfo=lscpu
