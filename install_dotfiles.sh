#!/bin/bash -e
set -x

INSTALL_LOG_DIR="$HOME/.install-log"

mkdir -p "$INSTALL_LOG_DIR"


# setup zsh
ZSH_DONE="$INSTALL_LOG_DIR/zsh.done"
if [ ! -e "$ZSH_DONE" ]; then
	echo "Install zsh plugins ..."
	zsh -c 'source ~/.zshrc' || true

	sudo chsh -s /usr/bin/zsh $USER
	touch "$ZSH_DONE"
fi

VIM_DONE="$INSTALL_LOG_DIR/vim.done"
if [ ! -e "$VIM_DONE" ]; then
	ln -svf $(which nvim) ~/bin/vim
	# Install vim-plug
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	# sudo pacman -S cmake  # needed to compile YCM

	# fix 

	nvim +PlugInstall +qall
	touch "$VIM_DONE"
fi
