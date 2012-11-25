# Starts tmux for new terminals (Bash or Zsh)
#
# Put this at the END of your ~/.zshrc (or ~/.bashrc) -- NOTE that any commands after this line will not run.
#    source ~/term-tools/config/shrc-tmux.sh
# This important restriction should be commented in ~/.zshrc (or ~/.bashrc) when you add the line.
#

# make sure that tmux is installed and configured
if [[ -s ~/.tmux.conf ]] && command -v tmux >/dev/null 2>&1; then

	# handle both Bash and Zsh
	if [ "$BASH_VERSION" ]; then
		rcfile=~/.bashrc
		this="${BASH_SOURCE[0]}"
	elif [ "$ZSH_VERSION" ]; then
		rcfile=~/.zshrc
		this=$0
	fi

	if [[ -s $rcfile ]]; then

		# make sure that this script is included last
		line=$(grep -n -E 'source\s+.*config/shrc-tmux.sh' $rcfile | head -n 1 | awk -F: '{print $1}')
		tot=$(wc -l < $rcfile)
		let diff=$tot-$line
		txt=$(tail -n $diff $rcfile)

		if [[ ! $txt =~ [^[:space:]] ]] ; then
			# this script is last

			# Now, check to make sure that we are in a fresh interactive non-tmux terminal
			# (if not, fall through since we're already in a shell)
			if [[ -z "$TMUX" ]] && [[ -n "$PS1" ]] && [[ "$TERM" == "xterm-256color" ]] && [[ $- = *i* ]]; then
				# attach to dangling sessions if there are any
				unattached=$(tmux ls | grep -v "attached" | head -n 1 | awk -F: '{print $1}')
				if [[ -n "$unattached" ]]; then
					echo "Re-attaching to session $unattached"
					sleep 1
					tmux -2 attach -t "$unattached" || tmux -2 new
				else
					tmux -2
				fi

				echo "tmux: exit $!"
			fi
		else
			echo -e "\e[1;31;48m"
			echo "ERROR: In this file:"
			echo "    $rcfile"
			echo "There cannot be any commands after this line:"
			echo "    source $this"
			echo "Move all commands before this (line $line)."
			echo -e "\e[m"
			echo "This message is coming from $this."
		fi
	fi
fi
