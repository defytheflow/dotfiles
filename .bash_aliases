# Author: Artyom Danilov
# Last modification date: January 27, 2020.

# CD (!)

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

# LS (!)
alias ls="ls -h -F --color=never --group-directories-first"
alias ll="ls -l"
alias la="ls -A"
alias lr="ls -R"

# CLEAR (!)
alias c=clear
alias cl=clear
alias clr=clear
alias cls=clear

# CAT (!)
alias ncat="cat -n"
alias tcat="cat -t"
alias lcat=lolcat

# VIM (!)
alias vi=vim
alias edit=vim

# FILE MANIPULATION (!)

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
alias delete=rm

# POWER OFF (!)
alias reboot="sudo reboot"
alias shutdown="sudo shutdown"

# BROWSER (!)
alias chrome=google-chrome
alias browser=chrome

# OTHER (!)

# Intuitive
alias now=date
alias cpuinfo=lscpu
alias count="ls -1 | wc -l" # Count number of files in directory

# Shorthands
alias su=sudo
alias h=history
alias f=file
alias gh="history | grep" # Find a command in the history

# INSTALLED PROGRAMS (!)

# Right versions
alias pip=pip3
alias python=python3

# Shorthands
alias py=python3

# 10. GIT (!)
alias git-stat="git status"
