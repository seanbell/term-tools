# TERMINAL CONFIG
# source from ~/.bashrc or ~/.zshrc

# find term-tools directory
if [ "$BASH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"
elif [ "$ZSH_VERSION" ]; then
	export TERM_TOOLS_DIR="$(builtin cd "$( dirname "${(%):-%N}" )/.." && pwd)"
fi

# add scripts to path
export PATH="$PATH:$TERM_TOOLS_DIR/scripts"

# store more shell history
export HISTSIZE=10000000
export SAVEHIST=10000000
export HISTFILESIZE=10000000

# if no editor is specified, assume vim
if [ ! "$EDITOR" ]; then
	export EDITOR="vim"
fi
if [ ! "$TERM_EDITOR" ]; then
	export TERM_EDITOR="$EDITOR"
fi

# enable full 256 colors -- so many colors!
if [[ "$TERM" == "xterm" ]]; then
    export TERM="xterm-256color"
fi

# solarized color scheme
if command -v dircolors >/dev/null 2>&1; then
	eval $(dircolors $TERM_TOOLS_DIR/dircolors-solarized/dircolors.ansi-dark)
fi

# syntax highlighting in less
if [[ -e /usr/share/source-highlight/src-hilite-lesspipe.sh ]]; then
  export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
  export LESS=' -R '
fi

# python autocomplete
[[ -s ~/.pythonrc ]] && export PYTHONSTARTUP=~/.pythonrc

# ack
alias ack='ack-grep'
alias sc='starcluster'

# ls with a 1-second timeout
if uname | grep Darwin > /dev/null; then
	# Mac version
	function ls_safe {
		$TERM_TOOLS_DIR/scripts/timeout3.sh -t 1 ls -G
	}
else
	function ls_safe {
		$TERM_TOOLS_DIR/scripts/timeout3.sh -t 1 ls --color=auto
	}
fi

# Disable flow-control with ctrl-s
# see http://unix.stackexchange.com/questions/12107/how-to-unfreeze-after-accidentally-pressing-ctrl-s-in-a-terminal
stty stop undef
stty -ixon
stty 115200

# ZSH-SPECIFIC CONFIG
if [ "$ZSH_VERSION" ]; then

	# ls after every cd
	function chpwd() {
		emulate -L zsh
		ls_safe
	}

	# terminal editor mode -- vim or emacs
	if [[ "$TERM_EDITOR" == "vim" ]] || [[ "$TERM_EDITOR" == "nvim" ]]; then
		bindkey -v
	elif [[ "$TERM_EDITOR" == "emacs" ]]; then
		bindkey -e
	fi

	# Better delete key and search with ctrl-R
	bindkey '\e[3~' delete-char
	bindkey '^R' history-incremental-pattern-search-backward

	# don't autocorrect move and mkdir commands
	alias cp='nocorrect cp '
	alias mv='nocorrect mv '
	alias mkdir='nocorrect mkdir '
fi

# BASH-SPECIFIC CONFIG
if [ "$BASH_VERSION" ]; then

	# terminal editor mode -- vim or emacs
	if [[ "$TERM_EDITOR" == "vim" ]] || [[ "$TERM_EDITOR" == "nvim" ]]; then
		set -o vi
	elif [[ "$TERM_EDITOR" == "emacs" ]]; then
		set -o emacs
	fi

	# ls after every cd
	function cd()  {
		 builtin cd "$@" && ls_safe
	}

	# cdd browser: navigate with hjkl, esc: cancel, enter: use that dir
	# (unfortunately this does not work in zsh)
	if [ -s $TERM_TOOLS_DIR/cdd/cdd.sh ]; then
		alias cdd=". $TERM_TOOLS_DIR/cdd/cdd.sh"
	fi

	# Custom terminal: blue path and yellow git branch
	#export PROMPT_DIRTRIM=2  # uncomment to trim to 2 directories
	DEFAULT_COLOR="\[\e[0m\]"
	PS1_COLOR="\[\e[34m\]"
	GIT_COLOR="\[\e[33m\]"
	TITLEBAR="\[\e]0;\h \w\007\]"
	if command -v __git_ps1 >/dev/null 2>&1; then
	  PS1="$TITLEBAR\n$PS1_COLOR\h:\w$GIT_COLOR\$(__git_ps1)$PS1_COLOR\n \$$DEFAULT_COLOR "
	else
	  PS1="$TITLEBAR\n$PS1_COLOR\h:\w\n \$$DEFAULT_COLOR "
	fi

	# don't put duplicate lines or lines starting with space in the history.
	export HISTCONTROL=ignoreboth

	# don't clobber history
	shopt -s histappend

	# check the window size after each command and, if necessary,
	# update the values of LINES and COLUMNS.
	shopt -s checkwinsize

	# automatically correct cd spelling errors
	shopt -s cdspell

fi
