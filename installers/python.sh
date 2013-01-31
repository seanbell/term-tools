#!/bin/bash
set -e

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

sudo pip install rope pep8 pyflakes

ln $@ -s ~/term-tools/config/pythonrc ~/.pythonrc
ln $@ -s ~/term-tools/config/inputrc ~/.inputrc

echo "run with -f to overwrite dotfiles"
