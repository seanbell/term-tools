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

if command -v git >/dev/null 2>&1; then
	echo "git: exists"
else
	pkg_install git
fi

# store git user info safely (use git config --get to avoid injection)
GIT_USER_NAME="$(git config --get user.name 2>/dev/null || true)"
GIT_USER_EMAIL="$(git config --get user.email 2>/dev/null || true)"

# use template
cp -f "$TERM_TOOLS_DIR/config/gitconfig-template" "$TERM_TOOLS_DIR/config/gitconfig"

# this will fail if it already exists, so we are safe
ln -snf "$@" "$TERM_TOOLS_DIR/config/gitconfig" ~/.gitconfig

# restore git user info
if [ -n "$GIT_USER_NAME" ]; then
	git config --global user.name "$GIT_USER_NAME"
fi
if [ -n "$GIT_USER_EMAIL" ]; then
	git config --global user.email "$GIT_USER_EMAIL"
fi
