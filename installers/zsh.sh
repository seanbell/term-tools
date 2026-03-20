#!/bin/bash

# find term-tools directory
if [ "$BASH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"
elif [ "$ZSH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${(%):-%N}" )/.." && pwd)"
fi
builtin cd "$TERM_TOOLS_DIR"
source "$TERM_TOOLS_DIR/installers/_common.sh"

# tmp file for this script
ZSHRC_TMP="$TERM_TOOLS_DIR/zshrc.tmp"

if command -v zsh >/dev/null 2>&1; then
	echo "zsh: exists"
else
	pkg_install zsh
fi

if [ ! -d ~/.oh-my-zsh ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [ -s /etc/zsh/zshrc ]; then
	# This fixes the up arrow key for ZSH default config.  The default is to
	# have the cursor go to the END of the line, but Ubuntu has overwritten this
	# ZSH default to go to the beginning of the line.  I think that's stupid,
	# so I'm reverting back to the default behavior
	if [ "$OS" = "Darwin" ]; then
		sed -e 's/vi-up-line-or-history/up-line-or-history/g' \
			-e 's/vi-down-line-or-history/down-line-or-history/' \
			/etc/zsh/zshrc > "$ZSHRC_TMP"
	else
		sed -e 's/vi-up-line-or-history/up-line-or-history/g' \
			-e 's/vi-down-line-or-history/down-line-or-history/' \
			/etc/zsh/zshrc > "$ZSHRC_TMP"
	fi
	sudo mv "$ZSHRC_TMP" /etc/zsh/zshrc
fi

# install oh-my-zsh config if it exists
if [ -d ~/.oh-my-zsh ]; then

	P="$(pwd)"
	builtin cd ~/.oh-my-zsh
	ln -snf "$@" "$TERM_TOOLS_DIR/config/sbell.zsh-theme" themes/sbell.zsh-theme
	ln -snf "$@" "$TERM_TOOLS_DIR/config/sbell-screen.zsh-theme" themes/sbell-screen.zsh-theme
	builtin cd "$P"

	# Install zsh plugins into custom/plugins (the standard oh-my-zsh way)
	if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
			~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	fi
	if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
		git clone https://github.com/zsh-users/zsh-autosuggestions.git \
			~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	fi

	# set theme and add plugins
	# Use perl for portability (macOS sed -i requires '' arg, GNU sed does not)
	perl -i -pe '
		s/^ZSH_THEME=.*$/if [[ "\$TERM" == "screen-256color" ]]; then ZSH_THEME="sbell-screen" else ZSH_THEME="sbell" fi/;
		s/^plugins=\(.*\)/plugins=(git vi-mode zsh-autosuggestions zsh-syntax-highlighting)/;
	' ~/.zshrc
else
	echo "ERROR: ~/.oh-my-zsh does not exist"
	exit 1
fi

# change default shell (non-fatal -- user can do this manually)
if [ "$OS" = "Darwin" ]; then
	chsh -s "$(which zsh)" || echo "NOTE: Run 'chsh -s $(which zsh)' manually to set zsh as default shell"
else
	sudo chsh "$USER" -s /bin/zsh || echo "NOTE: Run 'sudo chsh $USER -s /bin/zsh' manually to set zsh as default shell"
fi
