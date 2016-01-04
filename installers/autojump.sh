#!/bin/bash
set -e

# find term-tools directory
if [ "$BASH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"
elif [ "$ZSH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${(%):-%N}" )/.." && pwd)"
fi
builtin cd "$TERM_TOOLS_DIR"

builtin cd "autojump"
bash "install.sh" > /dev/null
