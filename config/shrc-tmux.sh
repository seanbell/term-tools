if [[ -z "$TMUX" ]] && [[ -n "$PS1" ]] && [[ "$TERM" == "xterm-256color" ]] && [[ $- = *i* ]]; then
	tmux -2 && exit
fi
