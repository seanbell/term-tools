# TERMINAL CONFIG
# source from ~/.bashrc or ~/.zshrc

# directory containing these tools
export TERM_TOOLS_DIR=~/term-tools

# 256 colors
if [[ "$TERM" == "xterm" ]]; then
    export TERM="xterm-256color"
fi

# autojump
[[ -f ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh
if [ "$BASH_VERSION" ]; then
	complete -F _cd j
fi

# call autojump, or fall back to cd if autojump fails
function j {
	local _p=$PWD
	j_impl $@

	if [[ "$PWD" == "$_p" ]] && [[ -d "$1" ]]; then
		cd $1
		echo -e "\\033[31m${PWD}\\033[0m"
	fi
}

# solarized color scheme
if command -v dircolors >/dev/null 2>&1; then
	eval $(dircolors $TERM_TOOLS_DIR/dircolors-solarized/dircolors.ansi-dark)
fi

# vim by default instead of emacs
set -o vi
export EDITOR="vim"
# enable core dumps
ulimit -c unlimited 2>/dev/null

# store more shell history
export HISTSIZE=1000000
export HISTFILESIZE=1000000

# syntax highlighting in less
if [ -e /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then
  export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
  export LESS=' -R '
fi

# ZSH-SPECIFIC CONFIG
if [ "$ZSH_VERSION" ]; then

	# ls after every cd
	function chpwd() {
		emulate -L zsh
		ls
	}

	# vim keybindings
	bindkey -v
	bindkey '\e[3~' delete-char
	#bindkey '^R' history-incremental-search-backward
	bindkey '^R' history-incremental-pattern-search-backward

fi

# BASH-SPECIFIC CONFIG
if [ "$BASH_VERSION" ]; then

	# ls after every cd
	function cd()  {
		 builtin cd "$@" && ls
    }

	# Custom terminal: blue, 2 levels of directories, and git branch
	export PROMPT_DIRTRIM=2
	DEFAULT_COLOR="\[\e[0m\]"
	PS1_COLOR="\[\e[1;32;40m\]"
	GIT_COLOR="\[\e[34m\]"
	TITLEBAR="\[\e]0;\h \w\007\]"
	if command -v __git_ps1 >/dev/null 2>&1; then
	  PS1="$TITLEBAR$PS1_COLOR\h:\w$GIT_COLOR\$(__git_ps1)$PS1_COLOR\$ $DEFAULT_COLOR"
	else
	  PS1="$TITLEBAR$PS1_COLOR\h:\w\$$DEFAULT_COLOR "
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
