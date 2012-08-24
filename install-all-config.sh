#!/bin/bash
set -x -e

# install vim setup
./install-vim-config.sh $@

# install autojump for both bash and zsh (if installed)
TMP_AUTOJUMP_SH=~/.autojump-term-tools.tmp
for f in zsh bash; do
	if command -v $f >/dev/null 2>&1; then
		echo "Installing autojump into $HOME ($f)..."
		SRC_AUTOJUMP_SH=~/.autojump/etc/profile.d/autojump.$f
		cd autojump
		./install.sh --$f > /dev/null
		cd ..
		sed 's/^function j {$/function j_impl {/' < $SRC_AUTOJUMP_SH > $TMP_AUTOJUMP_SH
		mv -f $TMP_AUTOJUMP_SH $SRC_AUTOJUMP_SH
	fi
done
echo "Done"

# this will fail if it already exists, so we are safe
ln $@ -s ~/term-tools/config/gitconfig ~/.gitconfig
ln $@ -s ~/term-tools/config/tmux.conf ~/.tmux.conf

set +x
echo ""
echo " == INSTALL COMPLETE =="
echo ""
echo "run with -f to overwrite dotfiles"
echo ""
echo "Add this line to your bashrc:"
echo "    [[ -f ~/term-tools/config/shrc.sh ]] && source ~/term-tools/config/shrc.sh"
echo ""
echo "To have nice c++ reformatting, install astyle:"
echo "    sudo apt-get install astyle"
echo " ======================"
