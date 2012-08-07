# TERMINAL CONFIG
# source from ~/.bashrc

# directory containing these tools
export TERM_TOOLS_DIR=~/term-tools

# 256 colors
if [ "$TERM" == "xterm" ]; then
    export TERM="xterm-256color"
fi

# autojump
[[ -f ~/.autojump/etc/profile.d/autojump.bash ]] && source ~/.autojump/etc/profile.d/autojump.bash
complete -F _cd j

# solarized color scheme
if command -v dircolors >/dev/null 2>&1; then
	eval $(dircolors $TERM_TOOLS_DIR/dircolors-solarized/dircolors.ansi-dark)
fi
