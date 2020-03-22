#!/usr/bin/zsh

# -----------------------------------------------------------------------------
# | File:      wsl.sh
# -----------------------------------------------------------------------------
# | Modified:  20 March, 2020
# -----------------------------------------------------------------------------
# | Author:    Artyom Danilov
# -----------------------------------------------------------------------------

echo "Running ${0}"

# /mnt/c/Users/YourUserName
export WINHOME="$(wslpath $(cmd.exe /C 'echo | set /p _=%USERPROFILE%' 2>/dev/null))"

# /mnt/c/Users/YourUserName/Desktop
export WINDESK="${WINHOME}/Desktop"
