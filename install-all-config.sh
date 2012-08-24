#!/bin/bash

# if -f, make sure it is intended
for f in $@; do
	if [ "$f" == "-f" ]; then
		echo "Note: -f was provided as an argument, which may overwrite any existing configuration"
		read -r -p "Are you sure? [y/N] " response
		case $response in
			[yY][eE][sS]|[yY])
				:
				;;
			*)
				exit 1
				;;
		esac
	else
		echo "Error: unknown argument: $f"
		exit 1
	fi
done

# trap errors
function print_err() {
	echo "ERROR: install incomplete"
}
trap print_err ERR

set -x -e

# install vim setup
./install-vim-config.sh $@

# store git user info
FIX_GIT_USER=~/term-tools/fix-git-user.sh
git config -l | grep "^user" | sed 's/^/git config --global /' | sed 's/=/ "/' | sed 's/$/"/' > $FIX_GIT_USER

# this will fail if it already exists, so we are safe
ln $@ -s ~/term-tools/config/gitconfig ~/.gitconfig
ln $@ -s ~/term-tools/config/tmux.conf ~/.tmux.conf

source $FIX_GIT_USER
rm $FIX_GIT_USER

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

# install oh-my-zsh config if it exists
if [ -d ~/.oh-my-zsh ]; then
	cd ~/.oh-my-zsh

	if [ -d custom.backup ]; then
		rm -rf custom
	else
		mv custom custom.backup
	fi

	ln $@ -s ~/term-tools/oh-my-zsh-custom custom
	ln $@ -s ~/term-tools/config/sbell.zsh-theme themes/sbell.zsh-theme
	cd -

	# set theme and add syntax plugin
	sed -E -e 's/ZSH_THEME=.*$/ZSH_THEME="sbell"/' -e 's/plugins=\((.*)\)/plugins=(\1 zsh-syntax-highlighting)/' \
		-i .before-sbell ~/.zshrc
fi

set +x
echo ""
echo " == INSTALL COMPLETE =="
echo ""
echo "To overwrite existing config, rerun with -f (this will delete any existing configuration)"
echo ""
echo "Add this line to your bashrc or zshrc:"
echo "    [[ -f ~/term-tools/config/shrc.sh ]] && source ~/term-tools/config/shrc.sh"
echo ""
echo " ======================"
