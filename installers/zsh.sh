#!/bin/bash
set -e

if command -v zsh >/dev/null 2>&1; then
	echo "zsh: exists"
elif command -v apt-get >/dev/null 2>&1; then
	# ubuntu
	sudo apt-get install zsh
elif command -v /opt/local/bin/port >/dev/null 2>&1; then
	# macport
	sudo port install zsh
else
	echo "ERROR: git is not installed"
	exit 1
fi

if [ ! -d ~/.oh-my-zsh ]; then
	wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
fi

# install oh-my-zsh config if it exists
if [ -d ~/.oh-my-zsh ]; then
	cd ~/.oh-my-zsh

	if [ -d custom.backup ]; then
		rm -rf custom
	else
		mv custom custom.backup
	fi

	ln $@ -s ~/term-tools/oh-my-zsh-custom/zsh-syntax-highlighting plugins/zsh-syntax-highlighting
	ln $@ -s ~/term-tools/config/sbell.zsh-theme themes/sbell.zsh-theme
	cd -

	# set theme and add syntax plugin
	ZSHRC_TMP=~/term-tools/zshrc-tmp
	sed -e 's/ZSH_THEME=.*$/ZSH_THEME="sbell"/' -e 's/plugins=\((.*)\)/plugins=(\1 zsh-syntax-highlighting)/' -e 's/zsh-syntax-highlighting zsh-syntax-highlighting/zsh-syntax-highlighting/' ~/.zshrc > $ZSHRC_TMP
	mv -f $ZSHRC_TMP ~/.zshrc
else
	echo "ERROR: ~/.oh-my-zsh does not exist"
	exit 1
fi

