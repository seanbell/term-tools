#!/bin/bash
echo "$0: TERM-TOOLS INSTALLER"
echo ""

if [ ! "$BASH_VERSION" ]; then
	echo "Error: installer must be run from bash"
	exit 1
fi

# allow for remote installation
if [ ! -t 0 ]; then
	echo "$0 run from non-terminal -- installing in default ~/term-tools location"
	if [[ ! -d ~/term-tools ]]; then
		echo "Cloning into term-tools"
		sudo apt-get install -y git
		git clone https://github.com/seanbell/term-tools ~/term-tools
		cd ~/term-tools
		bash install.sh
		exit
	fi
fi

# find term-tools
export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
echo "TERM_TOOLS_DIR=$TERM_TOOLS_DIR"
cd $TERM_TOOLS_DIR

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

echo "Update submodules..."
git pull origin master
git submodule init
git submodule update --init --recursive

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
		# Choice of single/double quotes is intentional below to escape some variables but not others
		echo "Patching $f..."
		if [[ $(grep -c "source \"$TERM_TOOLS_DIR/config/shrc.sh\"" $f) == "0" ]]; then
			echo '' >> $f
			echo '# TERM-TOOLS' >> $f
			echo "# (patched by $TERM_TOOLS_DIR/install.sh on $(date))" >> $f
			echo "[[ -s \"$TERM_TOOLS_DIR/config/shrc.sh\" ]] && source \"$TERM_TOOLS_DIR/config/shrc.sh\"" >> $f
		fi
		if [[ $(grep -c 'source "$TERM_TOOLS_DIR/config/shrc-tmux.sh"' $f) == "0" ]]; then
			echo '# Start all new shells inside tmux (if installed).  It must be the last command in this file.' >> $f
			echo '[[ -s "$TERM_TOOLS_DIR/config/shrc-tmux.sh" ]] && source "$TERM_TOOLS_DIR/config/shrc-tmux.sh"' >> $f
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
