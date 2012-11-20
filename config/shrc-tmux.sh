# Starts tmux for new terminals
#
# Put this at the END of your ~/.zshrc -- NOTE that any commands after this line will not run.
#    source ~/term-tools/config/shrc-tmux.sh
# This important restriction should be commented in ~/.zshrc when you add the line.
#

# make sure that this script is last
line=$(grep -n -E 'source\s+.*config/shrc-tmux.sh' ~/.zshrc | head -n 1 | awk -F: '{print $1}')
tot=$(wc -l < ~/.zshrc)
let diff=$tot-$line
txt=$(tail -n $diff ~/.zshrc)

if [[ ! $txt =~ [^[:space:]] ]] ; then
	# this script is last

	# Now, check to make sure that we are in a fresh interactive non-tmux terminal
	if [[ -z "$TMUX" ]] && [[ -n "$PS1" ]] && [[ "$TERM" == "xterm-256color" ]] && [[ $- = *i* ]]; then
		tmux -2 && exit
	fi
else
	echo -e "\e[1;31;48m"
	echo "ERROR: In this file:"
	echo "    ~/.zshrc"
    echo "There cannot be any commands after this line:"
	echo "    source $0"
	echo "Move all commands before this (line $line)."
	echo -e "\e[m"
	echo "This message is coming from $0."
fi
