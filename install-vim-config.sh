#!/bin/bash
set -x

# Submodules
git pull
git submodule init
git submodule update

if [ -d ~/.vim ]; then
	if [ "$1" == "-f" ]; then
		echo "Note: deleting ~/.vim"
		rm -rf ~/.vim
	else
		echo "Error: .vim exists.  Move or delete ~/.vim"
		exit 1
	fi
fi

# Install dotfiles (this will fail it already exists so we are safe)
ln $@ -s ~/term-tools/vim ~/.vim
ln $@ -s ~/term-tools/config/vimrc ~/.vimrc
ln $@ -s ~/term-tools/config/gvimrc ~/.gvimrc

echo "run with -f to overwrite dotfiles"

