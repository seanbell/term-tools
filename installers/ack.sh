#!/bin/bash

# find term-tools directory
if [ "$BASH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"
elif [ "$ZSH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${(%):-%N}" )/.." && pwd)"
fi
builtin cd "$TERM_TOOLS_DIR"
source "$TERM_TOOLS_DIR/installers/_common.sh"

if command -v ack >/dev/null 2>&1 || command -v ack-grep >/dev/null 2>&1; then
	echo "ack: exists"
elif [ "$PKG_MANAGER" = "apt-get" ]; then
	sudo apt-get install -y ack-grep
elif [ "$PKG_MANAGER" = "brew" ]; then
	brew install ack
elif [ "$PKG_MANAGER" = "dnf" ]; then
	sudo dnf install -y ack
else
	echo "ERROR: ack is not installed"
	exit 1
fi

ln -snf "$@" "$TERM_TOOLS_DIR/config/ackrc" ~/.ackrc
