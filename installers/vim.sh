#!/bin/bash
set -e

if [ -d ~/.vim ]; then
	if [ "$1" == "-f" ]; then
		echo "Note: deleting ~/.vim"
		rm -rf ~/.vim
	else
		echo "Error: .vim exists.  Move or delete ~/.vim"
		exit 1
	fi
fi

if [[ "$DESKTOP_SESSION" == "ubuntu" ]] || [[ "$DESKTOP_SESSION" == "ubuntu" ]]; then
	if command -v apt-get >/dev/null 2>&1; then
		# vim-gnome integration
		sudo apt-get install -y vim-gnome
	fi
fi

# Install dotfiles (this will fail it already exists so we are safe)
ln $@ -s ~/term-tools/vim ~/.vim
ln $@ -s ~/term-tools/config/vimrc ~/.vimrc
ln $@ -s ~/term-tools/config/gvimrc ~/.gvimrc

echo "run with -f to overwrite dotfiles"

