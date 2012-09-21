#!/bin/bash
set -e

if command -v python >/dev/null 2>&1; then
	echo "python exists"
else
	echo "ERROR: python is not installed"
	exit 1
fi

ln $@ -s ~/term-tools/config/pythonrc ~/.pythonrc
ln $@ -s ~/term-tools/config/inputrc ~/.inputrc

echo "run with -f to overwrite dotfiles"
