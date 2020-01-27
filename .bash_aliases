# Author: Artyom Danilov
# Last modification date: January 27, 2020.

# 1. MOVEMENT (!)

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

# 2. LS (!)
alias ls="ls --color=never"
alias dir=ls

# 3. CLEAR (!)
alias c=clear
alias cl=clear
alias clr=clear
alias cls=clear

# 4. VIM (!)
alias vi=vim
alias edit=vim

# 5. FILE MANIPULATION (!)

# Protection
alias rm="rm -I --preserve-root"
alias mv="mv -i"
alias cp="cp -i"

alias mkdir="mkdir -p"

# Explicitness
alias copy=cp
alias move=mv
alias remove=rm
alias delete=rm

# 6. POWER OFF
alias reboot="sudo reboot"
alias shutdown="sudo shutdown"

# 7. BROWSER
alias chrome=google-chrome
alias browser=chrome

# 8. OTHER COMMANDS (!)

# Intuitive
alias now=date
alias cpuinfo=lscpu
alias count="ls -1 | wc -l" # Count number of files in directory

# Shorthand
alias h=history
alias gh="history | grep" # Find a command in the history

# 9. INSTALLED PROGRAMS (!)

# Right versions
alias pip=pip3
alias python=python3

# Shorthand
alias py=python3
alias lcat=lolcat

# 10. GIT (!)
alias git-stat="git status"
