#!/bin/sh

VIM_PLUG_DEST = '~/.vim/autoload/plug.vim'
VIM_PLUG_URL =  'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Copy all other files except for this.
sudo find . -maxdepth 1 -type f \( ! -name "Makefile" \) -exec cp -i {} ~/ \;
# Copy all files from 'bash/'.
sudo find bash python tmux zsh -maxdepth 1 -type f -exec cp -i {} ~/ \;
# Copy all files from 'vim/'.
sudo find vim -maxdepth 1 -type f -exec cp -i {} ~/ \;
# Install vim-plug
if [[ ! -f $(VIM_PLUG_DEST) ]]; then \
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs $(VIM_PLUG_URL) > /dev/null 2>&1; \
fi;
