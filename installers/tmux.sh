#!/bin/bash
set -e

if command -v tmux >/dev/null 2>&1; then
	echo "tmux: exists"
elif command -v apt-get >/dev/null 2>&1; then
	# ubuntu
	sudo apt-get install -y tmux xclip
elif command -v /opt/local/bin/port >/dev/null 2>&1; then
	# macport
	sudo port install tmux
else
	echo "ERROR: tmux is not installed"
	exit 1
fi

ln $@ -sn ~/term-tools/tmuxified ~/.tmux
ln $@ -sn ~/term-tools/tmuxified/tmux.conf ~/.tmux.conf
