#!/bin/bash
set -e

if command -v tmux >/dev/null 2>&1; then
	echo "tmux: exists"
elif command -v apt-get >/dev/null 2>&1; then
	# ubuntu
	sudo apt-get install -y tmux
elif command -v /opt/local/bin/port >/dev/null 2>&1; then
	# macport
	sudo port install tmux
else
	echo "ERROR: tmux is not installed"
	exit 1
fi

ln $@ -s ~/term-tools/config/tmux.conf ~/.tmux.conf

