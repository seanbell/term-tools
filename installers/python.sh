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

if command -v python3 >/dev/null 2>&1; then
	echo "python3 exists"
else
	pkg_install python3
fi

# Install Python CLI tools via pipx (respects PEP 668 externally-managed environments)

if ! command -v pipx >/dev/null 2>&1; then
	pkg_install pipx
fi
pipx ensurepath >/dev/null 2>&1 || true

PYTHON_TOOLS="pylint flake8 pycodestyle autopep8 pyflakes rstcheck isort"
for tool in $PYTHON_TOOLS; do
	if command -v "$tool" >/dev/null 2>&1; then
		echo "$tool: already installed"
	else
		pipx install "$tool" || echo "WARNING: failed to install $tool"
	fi
done

# jedi is a library (not a CLI tool) -- install it into the jedi-vim venv if needed
# jedi-vim bundles its own jedi, so this is optional

ln -snf "$@" "$TERM_TOOLS_DIR/config/pythonrc" ~/.pythonrc
ln -snf "$@" "$TERM_TOOLS_DIR/config/inputrc" ~/.inputrc

echo "run with -f to overwrite dotfiles"
