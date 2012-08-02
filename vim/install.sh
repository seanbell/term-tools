#!/bin/bash
set -x

if [ -d ~/.vim ] || [ -s ~/.vimrc ] || [ -s ~/.gvimrc ]; then
	echo "NOTE: ~/.vim or ~/.vimrc or ~/.gvimrc exists!  Please move your versions elsewhere."
	exit 1
fi

# Submodules
cd ..
git pull
git submodule init
git submodule update

# Install dotfiles
ln -s ~/term-tools/vim ~/.vim
ln -s ~/term-tools/vim/vimrc ~/.vimrc
ln -s ~/term-tools/vim/gvimrc ~/.gvimrc
