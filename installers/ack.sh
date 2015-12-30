#!/bin/bash

# find term-tools directory
if [ "$BASH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"
elif [ "$ZSH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${(%):-%N}" )/.." && pwd)"
fi
builtin cd "$TERM_TOOLS_DIR"

if command -v ack-grep >/dev/null 2>&1; then
	echo "ack: exists"
elif command -v apt-get >/dev/null 2>&1; then
	# ubuntu
	sudo apt-get install -y ack-grep
elif command -v brew >/dev/null 2>&1; then
	# homebrew
	brew install ack
else
	echo "ERROR: ack is not installed"
	exit 1
fi

ln $@ -s "$TERM_TOOLS_DIR/config/ackrc" ~/.ackrc
