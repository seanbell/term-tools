#!/bin/bash
set -x

# install vim
./install-vim-config.sh $@

# this will fail if it already exists, so we are safe
ln $@ -s ~/term-tools/config/gitconfig ~/.gitconfig
ln $@ -s ~/term-tools/config/tmux.conf ~/.tmux.conf
