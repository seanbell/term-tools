#!/bin/bash
set -e

if [[ "$DESKTOP_SESSION" == "ubuntu" ]]; then
	if command -v apt-get >/dev/null 2>&1; then
		sudo apt-get install -y vim-gnome ctags ack-grep
		# header for vim startify
		sudo apt-get install -y cowsay fortune fortunes-off fortunes-bofh-excuses
	else
		echo "Cannot find apt-get"
		exit 1
	fi
elif [ "$(uname)" == "Darwin" ]; then
	if command -v ack >/dev/null 2>&1; then
		echo "ack: installed"
	else
		if command -v brew >/dev/null 2>&1; then
			brew install ack
		elif command -v port >/dev/null 2>&1; then
			sudo port install p5-app-ack
		else
			echo "Please install: ack-grep"
			exit 1
		fi
	fi

	if [[ $(vim --version | grep -c "+conceal") == "0" ]]; then
		if command -v port >/dev/null 2>&1; then
			# macports
			sudo port selfupdate
			sudo port clean vim
			sudo port install                       vim +big+python27+ruby
			sudo port -n upgrade --enforce-variants vim +big+python27+ruby
		else
			echo "Please install: vim (with +big, +python27, and +ruby)"
			exit 1
		fi
	else
		echo "vim: installed"
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

