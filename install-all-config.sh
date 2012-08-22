#!/bin/bash
set -x

# install vim setup
./install-vim-config.sh $@

# install autojump
echo "Installing autojump into $HOME..."
SRC_AUTOJUMP_BASH=~/.autojump/etc/profile.d/autojump.bash
TMP_AUTOJUMP_BASH=~/.autojump-term-tools.tmp
cd autojump
./install.sh > /dev/null
cd ..
sed 's/^function j {$/function j_impl {/' < $SRC_AUTOJUMP_BASH > $TMP_AUTOJUMP_BASH
mv -f $TMP_AUTOJUMP_BASH $SRC_AUTOJUMP_BASH
echo "Done"

# this will fail if it already exists, so we are safe
ln $@ -s ~/term-tools/config/gitconfig ~/.gitconfig
ln $@ -s ~/term-tools/config/tmux.conf ~/.tmux.conf

set +x
echo "run with -f to overwrite dotfiles"
echo ""
echo "Add this line to your bashrc:"
echo "    [[ -f ~/term-tools/config/bashrc.sh ]] && source ~/term-tools/config/bashrc.sh"
echo ""
echo "To have nice c++ reformatting, install astyle:"
echo "    sudo apt-get install astyle"

