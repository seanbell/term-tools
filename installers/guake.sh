#!/bin/bash
set -e

if command -v apt-get >/dev/null 2>&1; then
	sudo apt-get install guake
else
	echo "ERROR: this installer only works for Ubuntu"
	exit 0
fi

xmodmap -e "keycode 9 = F12"
xmodmap -e "keycode 66 = Escape"
xmodmap -pke > ~/.Xmodmap
ln -s $@ ~/term-tools/config/xinitrc ~/.xinitrc
