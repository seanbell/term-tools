#!/bin/bash
echo "$0: TERM-TOOLS INSTALLER"
echo ""

# allow for remote installation
if [[ ! -d ~/term-tools ]]; then
	echo "Cloning into term-tools"
	sudo apt-get install -y git
	git clone https://github.com/seanbell/term-tools ~/term-tools
	cd ~/term-tools
	./install.sh
	exit
fi

cd ~/term-tools

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

set -e

# Load submodules
git pull
git submodule init
git submodule update --init --recursive

# update apt-get
# sudo apt-get update -y

# run through the installers
for f in $(ls -1 installers/*.sh); do
	inst="y"
	read -r -p "Install config for $(basename $f .sh)? [Y/n] " response
	if [ -z "$response" ] || [[ $response =~ ^[Yy]$ ]] ;  then
		if bash $f $@; then
			echo "SUCCESS: $f"
		else
			echo "ERROR: $f"
			exit 1
		fi
	else
		echo "SKIPPING: $f"
	fi
done

for f in ~/.zshrc ~/.bashrc; do
	if [[ -s $f ]]; then
		if [[ $(grep -c 'source ~/term-tools/config/shrc.sh' $f) == "0" ]]; then
			echo '[[ -s ~/term-tools/config/shrc.sh ]] && source ~/term-tools/config/shrc.sh' >> $f
		fi
		if [[ $(grep -c 'source ~/term-tools/config/shrc-tmux.sh' $f) == "0" ]]; then
			echo '' >> $f
			echo '# This line starts all new shells inside tmux (if tmux is installed and set up).' >> $f
			echo '# It must be the last command in this file.' >> $f
			echo '[[ -s ~/term-tools/config/shrc-tmux.sh ]] && source ~/term-tools/config/shrc-tmux.sh' >> $f
		fi
	fi
done


set +x
echo ""
echo " == INSTALL COMPLETE =="
echo ""
echo "To overwrite existing config, rerun with -f (this will delete any existing configuration)"
echo ""
echo "To make zsh the default shell, run:"
echo "    sudo chsh $USER -s /bin/zsh"
echo "and then restart the terminal (or re-login for Ubuntu)"
echo ""
echo " ======================"
