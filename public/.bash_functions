# Author: Artyom Danilov
# Last modification date: January 16, 2020.

# Hides a file
function hide() {
    for file in $@; do
        if [[ ${file::1} != . ]]; then
            mv $file .$file
        fi
    done
}
export -f hide

# Shows a hidden file
function show() {
    for file in $@; do
        if [[ ${file::1} == . ]]; then
            mv $file ${file/./}
        fi
    done
}
export -f show

# Prints to the 'stderr'
function echoerr() {
    printf "%s\n" "$*" 1>&2
}
export -f echoerr

# Prints the text in the center of the terminal
function echoc() {
    w=$(stty size | cut -d" " -f2)
    l=${#1}
    printf "%"$((l+(w-l)/2))"s\n" "$1"
}
export -f echoc

# Returns 0 if $1 is a positive integer
function isuint() {
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}
export -f isuint

# Returns number of files in directory
function filenum() {
    echo $(find $1 -maxdepth 1 -type f | wc -l)
}
export -f filenum

# Returns 0 if directory is empty, else 1
function isempty() {
    if [[ $(ls -A -1 $1 | wc -l) -eq 0 ]]; then
        return 0
    else
        return 1
    fi
}
export -f isempty

# Create and enter inside a directory
function mkcd() {
    mkdir -p $1
    cd $1
}
export -f mkcd

# cd into directory and list it
function cl() {
    cd $1
    ls
}
export -f cl
