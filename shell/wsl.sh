#!/usr/bin/sh

# ------------------------------------------------------------------------------
# | File:      wsl.sh
# ------------------------------------------------------------------------------
# | Modified:  20 March, 2020
# ------------------------------------------------------------------------------
# | Author:    Artyom Danilov
# ------------------------------------------------------------------------------

echo "Running ${0}"

# Like: '/mnt/c/Users/UserName'
WINHOME="$(wslpath "$(cmd.exe /C 'echo | set /p _=%USERPROFILE%' 2>/dev/null)")"
export WINHOME

# /mnt/c/Users/YourUserName/Desktop
export WINDESK="${WINHOME}/Desktop"
