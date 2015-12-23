#!/bin/bash
set -e

if [ -f /proc/version ] && [ $(grep -c Ubuntu /proc/version) -gt 0 ]; then
	echo test
	if command -v apt-get >/dev/null 2>&1; then
		# install utilities
		sudo apt-get install -y ctags ack-grep
		# header for vim startify
		sudo apt-get install -y cowsay fortune fortunes-off fortunes-bofh-excuses

		read -r -p "Install newest vim from source (recommended)? [Y/n] " response
		if [ -z "$response" ] || [[ $response =~ ^[Yy]$ ]] ;  then

			####
			# BUILD NEWEST VIM FROM SOURCE
			# Based on: https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
			# uninstall repo version

			echo "Uninstall old vim..."
			sudo apt-get remove -y vim vim-runtime vim-gnome gvim \
				vim-tiny vim-common vim-gui-common

			echo "Install vim prerequisites..."
			sudo apt-get install -y \
				libncurses5-dev libgnome2-dev libgnomeui-dev \
				libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
				libcairo2-dev libx11-dev libxpm-dev libxt-dev \
				python-dev ruby-dev mercurial

			echo "Clone newest vim source code to vim-src/..."
			sudo rm -rf vim-src
			hg clone https://code.google.com/p/vim/ vim-src

			echo "Build vim from source..."
			P="$(pwd)"
			cd vim-src
			./configure \
				--with-features=huge \
				--enable-rubyinterp \
				--enable-pythoninterp \
				--with-python-config-dir=/usr/lib/python2.7-config \
				--enable-perlinterp \
				--enable-luainterp \
				--enable-gui=gtk2 \
				--enable-cscope \
				--prefix=/usr
			make VIMRUNTIMEDIR=/usr/share/vim/vim74
			sudo make install
			cd "$P"

			echo "Update alternatives"
			sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
			sudo update-alternatives --set editor /usr/bin/vim
			sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
			sudo update-alternatives --set vi /usr/bin/vim

			echo "Done building vim"
		else
			sudo apt-get install -y vim-gnome
		fi
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
		elif command -v /opt/local/bin/port >/dev/null 2>&1; then
			sudo port install p5-app-ack
		else
			echo "Please install: ack-grep"
			exit 1
		fi
	fi

	if [[ $(vim --version | grep -c "+conceal") == "0" ]]; then
		if command -v /opt/local/bin/port >/dev/null 2>&1; then
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

