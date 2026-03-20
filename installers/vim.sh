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

if [ "$OS" = "Darwin" ]; then
	# Homebrew vim has better feature flags (+python3, +lua, etc.)
	pkg_install vim
	pkg_install ctags
	pkg_install cowsay
	pkg_install fortune
elif [ "$OS" = "Linux" ]; then
	if [ "$PKG_MANAGER" = "apt-get" ]; then
		sudo apt-get install -y vim-gtk3 ctags
		sudo apt-get install -y cowsay fortune fortunes-off fortunes-bofh-excuses || true
	elif [ "$PKG_MANAGER" = "dnf" ]; then
		sudo dnf install -y vim-enhanced ctags cowsay fortune-mod
	else
		echo "ERROR: No known package manager for vim"
		exit 1
	fi
fi

# Handle old dotfiles
if [ -d ~/.vim ]; then
	if [ "$1" == "-f" ]; then
		echo "Note: deleting ~/.vim"
		rm -rf ~/.vim
	else
		echo "Error: .vim exists.  Move or delete ~/.vim"
		exit 1
	fi
fi

# Ensure all bundles have a doc/ dir so pathogen#helptags() doesn't error
for bundle in "$TERM_TOOLS_DIR"/vim/bundle/*/; do
	if [ ! -d "$bundle/doc" ]; then
		mkdir -p "$bundle/doc"
	fi
done

# Install dotfiles (this will fail if it already exists so we are safe)
ln -snf "$@" "$TERM_TOOLS_DIR/vim" ~/.vim
ln -snf "$@" "$TERM_TOOLS_DIR/config/vimrc" ~/.vimrc
ln -snf "$@" "$TERM_TOOLS_DIR/config/gvimrc" ~/.gvimrc

echo "run with -f to overwrite dotfiles"
