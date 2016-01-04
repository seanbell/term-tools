#!/bin/bash

# find term-tools directory
if [ "$BASH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"
elif [ "$ZSH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${(%):-%N}" )/.." && pwd)"
fi
builtin cd "$TERM_TOOLS_DIR"

# tmp file for this script
ZSHRC_TMP="$TERM_TOOLS_DIR/zshrc.tmp"

if command -v zsh >/dev/null 2>&1; then
	echo "zsh: exists"
elif command -v apt-get >/dev/null 2>&1; then
	# ubuntu
	sudo apt-get install -y zsh
elif command -v /opt/local/bin/port >/dev/null 2>&1; then
	# macport
	sudo port install zsh
else
	echo "ERROR: git is not installed"
	exit 1
fi

if [ ! -d ~/.oh-my-zsh ]; then
	wget --no-check-certificate http://install.ohmyz.sh -O - | sh
fi

if [ -s /etc/zsh/zshrc ]; then
	# This fixes the up arrow key for ZSH default config.  The default is to
	# have the cursor go to th END of the line, but Ubuntu has overwritten this
	# ZSH default to go to the beginning of the line.  I think that's stupid,
	# so I'm reverting back to the default behavior
	sed -e 's/vi-up-line-or-history/up-line-or-history/g' \
		-e 's/vi-down-line-or-history/down-line-or-history/' \
		/etc/zsh/zshrc > $ZSHRC_TMP
	sudo mv $ZSHRC_TMP /etc/zsh/zshrc
fi

# install oh-my-zsh config if it exists
if [ -d ~/.oh-my-zsh ]; then

	P="$(pwd)"
	builtin cd ~/.oh-my-zsh
	ln $@ -s "$TERM_TOOLS_DIR/oh-my-zsh-custom/zsh-syntax-highlighting" plugins/zsh-syntax-highlighting
	ln $@ -s "$TERM_TOOLS_DIR/config/sbell.zsh-theme" themes/sbell.zsh-theme
	ln $@ -s "$TERM_TOOLS_DIR/config/sbell-screen.zsh-theme" themes/sbell-screen.zsh-theme
	builtin cd "$P"

	# set theme and add syntax plugin
	sed -e 's/^ZSH_THEME=.*$/if [[ "$TERM" == "screen-256color" ]]; then ZSH_THEME="sbell-screen" else ZSH_THEME="sbell" fi/' \
		-e 's/^plugins=(\(.*\))/plugins=(\1 zsh-syntax-highlighting)/' \
		-e 's/zsh-syntax-highlighting zsh-syntax-highlighting/zsh-syntax-highlighting/' \
		~/.zshrc > $ZSHRC_TMP

	mv -f $ZSHRC_TMP ~/.zshrc
else
	echo "ERROR: ~/.oh-my-zsh does not exist"
	exit 1
fi

# change default shell
sudo chsh $USER -s /bin/zsh
