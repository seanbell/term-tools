#!/bin/bash
set -e

# find term-tools directory
if [ "$BASH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"
elif [ "$ZSH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${(%):-%N}" )/.." && pwd)"
fi
builtin cd "$TERM_TOOLS_DIR"
source "$TERM_TOOLS_DIR/installers/_common.sh"

## tmux

if command -v tmux >/dev/null 2>&1; then
	echo "tmux: exists ($(tmux -V))"
else
	if [ "$OS" = "Darwin" ]; then
		pkg_install tmux
	elif [ "$PKG_MANAGER" = "apt-get" ]; then
		sudo apt-get install -y tmux
	elif [ "$PKG_MANAGER" = "dnf" ]; then
		sudo dnf install -y tmux
	else
		echo "ERROR: tmux is not installed and no known package manager"
		exit 1
	fi
fi

# Install xclip on Linux for clipboard support
if [ "$OS" = "Linux" ]; then
	pkg_install xclip
fi

tmux -V
ln -snf "$@" "$TERM_TOOLS_DIR/config/tmux.conf" ~/.tmux.conf
