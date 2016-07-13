#!/bin/bash
set -e

# find term-tools directory
if [ "$BASH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"
elif [ "$ZSH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${(%):-%N}" )/.." && pwd)"
fi
builtin cd "$TERM_TOOLS_DIR"

if command -v python >/dev/null 2>&1; then
	echo "python exists"
else
	echo "ERROR: python is not installed"
	exit 1
fi

if command -v pip >/dev/null 2>&1; then
	echo "pip exists"
elif command -v apt-get >/dev/null 2>&1; then
	sudo apt-get install -y python-pip
else
	echo "ERROR: pip is not installed"
fi

# checkers for vim plugins
sudo pip install --upgrade pylint flake8 pep8 autopep8 pyflakes jedi rstcheck isort

ln $@ -s $TERM_TOOLS_DIR/config/pythonrc ~/.pythonrc
ln $@ -s $TERM_TOOLS_DIR/config/inputrc ~/.inputrc

echo "run with -f to overwrite dotfiles"
