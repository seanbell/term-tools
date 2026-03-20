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

# Check for source-highlight lesspipe in known locations
LESSPIPE=""
if [ -s /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then
	LESSPIPE="/usr/share/source-highlight/src-hilite-lesspipe.sh"
elif command -v brew >/dev/null 2>&1; then
	BREW_LESSPIPE="$(brew --prefix)/share/source-highlight/src-hilite-lesspipe.sh"
	if [ -s "$BREW_LESSPIPE" ]; then
		LESSPIPE="$BREW_LESSPIPE"
	fi
fi

if [ -n "$LESSPIPE" ]; then
	echo "source-highlight: exists ($LESSPIPE)"
else
	pkg_install source-highlight
fi
