#!/usr/bin/zsh

# ------------------------------------------------------------------------------
# | File:      prompt.sh
# ------------------------------------------------------------------------------
# | Modified:  March 20, 2020
# ------------------------------------------------------------------------------
# | Author:    Artyom Danilov
# ------------------------------------------------------------------------------

echo "Running ${0}"

# ------------------------------------------------------------------------------
#                                    Colors
# ------------------------------------------------------------------------------

if [ -n "${BASH_VERSION}" ]; then

    start_color='\[\e[38;5;'
    end_color='m\]'

    nl='\n'
    reset='\[\e[0m\]'

elif [ -n "${ZSH_VERSION}" ]; then

    start_color=$'%{\e[38;5;'
    end_color='m%}'

    nl=$'\n'
    reset=$'%{\e[0m%}'
fi

cyan="${start_color}45${end_color}"
green="${start_color}82${end_color}"
limegreen="${start_color}154${end_color}"
orange="${start_color}202${end_color}"
purple="${start_color}135${end_color}"
red="${start_color}9${end_color}"
white="${start_color}15${end_color}"

# ------------------------------------------------------------------------------
#                              Special Variables
# ------------------------------------------------------------------------------

if [ -n "${BASH_VERSION}" ]; then

    username='\u'
    hostname='\h'
    absdir='\w'
    reldir='\W'

elif [ -n "${ZSH_VERSION}" ]; then

    username='%n'
    hostname='%M'
    absdir='%~'
    reldir='%1~'
fi

# ---------------------------------------------------------------------------- #
#                                   Statuses                                   #
# ---------------------------------------------------------------------------- #

success="${green}:)${reset}"
failure="${red}:(${reset}"

committed="${green}✓${reset}"
uncommitted="${red}✗${reset}"

# ---------------------------------------------------------------------------- #
#                                    Prompt                                    #
# ---------------------------------------------------------------------------- #

# 'BASH_VERSION' only defined in Bash
# 'PROMPT_COMMAND' is a special environment variable name known to Bash
[ -n "${BASH_VERSION}" ] && PROMPT_COMMAND=my_prompt

# 'ZSH_VERSION' only defined in Zsh
# 'precmd' is a special function name known to Zsh
[ -n "${ZSH_VERSION}" ] && precmd() { my_prompt; }

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

        if [ -z "$(git status -s)" ]; then
            git_status="${committed}"
        else
            git_status="${uncommitted}"
        fi

        # Colorize branch and commits.
        branch="${cyan}${branch}"
        sep="${white}|"
        commits="${cyan}${commits}"

        # Putting all together.
        branch=" ${white}(${branch}${sep}${commits}${sep}${git_status}${white} )"
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
