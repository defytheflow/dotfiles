# Author: Artyom Danilov

# Last modification date: February 14, 2020.

# CD ----------------------------------

# Typing mistakes
alias cd..="cd .."
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
alias ll="ls -l"
alias la="ls -A"
alias lr="ls -R"

# DIR ---------------------------------
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# CLEAR -------------------------------
alias c=clear
alias cl=clear
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
alias edit=vim

# FILE MANIPULATION -------------------

# Protection
alias rm="rm -I --preserve-root"
alias mv="mv -i"
alias cp="cp -i"

alias mkdir="mkdir -p"
alias rmdir="rmdir -p"

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

# OTHER -------------------------------
alias now=date
alias weather="curl http://wttr.in/"
alias cpuinfo=lscpu

# SHORTHANDS --------------------------
alias f=file
alias g=git
alias h=history
alias gh="history | grep" # Find a command in the history
alias py=python3
alias su=sudo

# RIGHT VERSIONS ----------------------
alias pip=pip3
alias pylint=pylint3
alias python=python3
