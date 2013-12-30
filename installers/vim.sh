#!/bin/bash
set -e

if [[ "$DESKTOP_SESSION" == "ubuntu" ]]; then
	if command -v apt-get >/dev/null 2>&1; then
		# vim-gnome integration
		sudo apt-get install -y vim-gnome ctags
		# header for vim startify
		sudo apt-get install -y fortune cowsay
	fi
elif [[ $(vim --version | grep -c "+conceal") == "0" ]]; then
	if command -v /opt/local/bin/port >/dev/null 2>&1; then
		# macports
		sudo port selfupdate
		sudo port clean vim
		sudo port install                       vim +big+python27+ruby
		sudo port -n upgrade --enforce-variants vim +big+python27+ruby
	fi
fi

# Handle old dotfiles
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

