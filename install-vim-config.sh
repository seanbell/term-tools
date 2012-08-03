#!/bin/bash
set -x

# Submodules
git pull
git submodule init
git submodule update

# Install dotfiles (this will fail it already exists so we are safe)
ln $@ -s ~/term-tools/vim ~/.vim
ln $@ -s ~/term-tools/config/vimrc ~/.vimrc
ln $@ -s ~/term-tools/config/gvimrc ~/.gvimrc
