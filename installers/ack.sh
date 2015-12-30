#!/bin/bash

if command -v ack-grep >/dev/null 2>&1; then
	echo "ack: exists"
elif command -v apt-get >/dev/null 2>&1; then
	# ubuntu
	sudo apt-get install -y ack-grep
elif command -v brew >/dev/null 2>&1; then
	# homebrew
	brew install ack
else
	echo "ERROR: ack is not installed"
	exit 1
fi

ln $@ -s ~/term-tools/config/ackrc ~/.ackrc
