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
if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
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

	if [ "$PWD" != "$_p" ]; then
		ls
	fi
}

# solarized color scheme
if command -v dircolors >/dev/null 2>&1; then
	eval $(dircolors $TERM_TOOLS_DIR/dircolors-solarized/dircolors.ansi-dark)
fi
