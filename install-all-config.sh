#!/bin/bash
set -x

# install vim setup
./install-vim-config.sh $@

# install autojump
cd autojump
./install.sh

# this will fail if it already exists, so we are safe
ln $@ -s ~/term-tools/config/gitconfig ~/.gitconfig
ln $@ -s ~/term-tools/config/tmux.conf ~/.tmux.conf

echo "run with -f to overwrite dotfiles"
