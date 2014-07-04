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

if command -v apt-get >/dev/null 2>&1; then
	sudo apt-get install -y pylint
fi

# checkers for vim plugins
sudo pip install --upgrade flake8 pep8 autopep8 pyflakes jedi rstcheck isort

ln $@ -s ~/term-tools/config/pythonrc ~/.pythonrc
ln $@ -s ~/term-tools/config/inputrc ~/.inputrc

echo "run with -f to overwrite dotfiles"
