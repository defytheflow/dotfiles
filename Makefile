SRC_DIR     = /usr/local/src
SYMLINK_DIR = /usr/local/bin

.PHONY: install
install:
	sudo find bash -maxdepth 1 -type f -exec cp -i {} ~/ \;
	sudo find . -maxdepth 1 -type f \( ! -name "Makefile" \) -exec cp -i {} ~/ \;
	sudo cp vim/.vimrc ~/
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
