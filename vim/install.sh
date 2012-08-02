#!/bin/bash
set -x

if [ -s ~/.vimrc ] || [ -s ~/.gvimrc ]; then
	echo "NOTE: ~/.vimrc or ~/.gvimrc exists!  Please move your versions elsewhere."
	exit 1
fi

# Submodules
cd ..
git pull
git submodule init
git submodule update

# Install dotfiles
ln -s ~/term-tools/vim/vimrc ~/.vimrc
ln -s ~/term-tools/vim/gvimrc ~/.gvimrc
