#!/usr/bin/zsh

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                     _
#                     _ __  _ __ ___  _ __ ___  _ __ | |_
#                    | '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
#                    | |_) | | | (_) | | | | | | |_) | |_
#                    | .__/|_|  \___/|_| |_| |_| .__/ \__|
#                    |_|                       |_|
#
# ----------------------------------------------------------------------------
# | File: .prompt.sh
# ----------------------------------------------------------------------------
# | Modified: March 20, 2020
# ----------------------------------------------------------------------------
# | Author: Artyom Danilov
# ----------------------------------------------------------------------------
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

echo 'Running ~/.prompt.sh'

# ---------------------------------------------------------------------------- #
#                                    Colors                                    #
# ---------------------------------------------------------------------------- #

if [ -n "${ZSH_VERSION}" ]; then

    pre_zsh=$'%{\e[38;5;'
    post_zsh='m%}'

    cyan="${pre_zsh}45${post_zsh}"
    green="${pre_zsh}82${post_zsh}"
    limegreen="${pre_zsh}154${post_zsh}"
    orange="${pre_zsh}166${post_zsh}"
    purple="${pre_zsh}135${post_zsh}"
    red="${pre_zsh}9${post_zsh}"
    white="${pre_zsh}15${post_zsh}"

    nl=$'\n'
    reset=$'%{\e[0m%}'

elif [ -n "${BASH_VERSION}" ]; then

    pre_bash='\[\e[38;5;'
    post_bash='m\]'

    cyan="${pre_bash}45${post_bash}"
    green="${pre_bash}82${post_bash}"
    limegreen="${pre_bash}154${post_bash}"
    orange="${pre_bash}166${post_bash}"
    purple="${pre_bash}135${post_bash}"
    red="${pre_bash}9${post_bash}"
    white="${pre_bash}15${post_bash}"

    nl='\n'
    reset='\[\e[0m\]'
fi

# ---------------------------------------------------------------------------- #
#                              Special Variables                               #
# ---------------------------------------------------------------------------- #

if [ -n "${ZSH_VERSION}" ]; then

    username='%n'
    hostname='%M'
    absdir='%~'

elif [ -n "${BASH_VERSION}" ]; then

    username='\u'
    hostname='\h'
    absdir='\w'
fi

# ---------------------------------------------------------------------------- #
#                                   Statuses                                   #
# ---------------------------------------------------------------------------- #

success="${green}:)${reset}"
failure="${red}:(${reset}"

# ---------------------------------------------------------------------------- #
#                                    Prompt                                    #
# ---------------------------------------------------------------------------- #

# 'ZSH_VERSION' only defined in Zsh
# 'precmd' is a special function name known to Zsh
[ -n "${ZSH_VERSION}" ] && precmd() { my_prompt; }

# 'BASH_VERSION' only defined in Bash
# 'PROMPT_COMMAND' is a special environment variable name known to Bash
[ -n "${BASH_VERSION}" ] && PROMPT_COMMAND=my_prompt

# Gets executed each time prompt is drawn.
my_prompt() {

    # Get last command status
    if [ $? -eq 0 ]; then
        command_status=" ${success}"
    else
        command_status=" ${failure}"
    fi

    # Get git branch
    if git status >/dev/null 2>&1; then
        # Branch currently on.
        branch="$(git branch 2>/dev/null | grep "^*" | colrm 1 2)"

        # Number of commits in repository on branch.
        commits="$(git rev-list --count ${branch})"

        # Colorize branch and commits.
        branch="${cyan}${branch}"
        sep="${white}|"
        commits="${cyan}${commits}"

        # Putting all together.
        branch=" ${white}(${branch}${sep}${commits}${white})"
    else
        branch=''
    fi;

    # Set PS1
    PS1="${nl}${purple}${username}"             # username
    PS1+="${white} at ${orange}${hostname}"     # at host
    PS1+="${white} in ${limegreen}${absdir}"    # in directory
    PS1+="${branch}"                            # (branch|commits)
    PS1+="${command_status}"                    # :) or :(
    PS1+="${reset}${nl}\$ "
}

# Default
#PS1="$green\u@\h$reset:$blue\w$reset\$ "
