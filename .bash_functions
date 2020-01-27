# Author: Artyom Danilov
# Last modification date: January 27, 2020.

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
