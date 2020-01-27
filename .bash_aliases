# Author: Artyom Danilov
# Last modification date: January 27, 2020.

# For python3
alias py=python3;
alias python=python3;

# For pip
alias pip=pip3;

# For clear command
alias cls=clear;
alias cl=clear;
alias clr=clear;

# For ls command
alias dir=ls;

# For lolcat command
alias lcat=lolcat;

# For cp
alias copy=cp;

# For mv
alias move=mv;

# For rm
alias remove=rm;
alias delete=rm;

# For google-chrome
alias chrome=google-chrome;

# For vim
alias edit=vim

# Hides a file
function hide () {
    for file in $@; do
        if [[ ${file::1} != . ]]; then
            mv $file .$file
        fi
    done
}

# Shows a hidden file
function show () {
    for file in $@; do
        if [[ ${file::1} == . ]]; then
            mv $file ${file/./}
        fi
    done
}
