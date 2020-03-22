#!/bin/sh

echo "Running ${HOME}/.profile"

# If running bash
[ -n "${BASH_VERSION}" ] && [ -f "${HOME}/.bashrc" ] && . "${HOME}/.bashrc"
# If running zsh
[ -n "${ZSH_VERSION}" ] && [ -f "${HOME}/.zshrc" ] && . "${HOME}/.zshrc"

# Add user's private bins.
for dir in "${HOME}/bin" "${HOME}/.local/bin"; do
    [ -d "${dir}" ] && PATH="${dir}:${PATH}"
done
