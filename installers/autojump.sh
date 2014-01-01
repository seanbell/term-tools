#!/bin/bash
set -e

p=$(pwd)
cd autojump
./install.sh > /dev/null
cd "$p"
