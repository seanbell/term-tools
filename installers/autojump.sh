#!/bin/bash
set -e

# install autojump for both bash and zsh (if installed)
TMP_AUTOJUMP_SH=~/.autojump-term-tools.tmp
for f in zsh bash; do
	if command -v $f >/dev/null 2>&1; then
		echo "Installing autojump into $HOME ($f)..."
		SRC_AUTOJUMP_SH=~/.autojump/etc/profile.d/autojump.$f
		cd autojump
		./install.sh --$f > /dev/null
		cd ..
		sed 's/^function j {$/function j_impl {/' < $SRC_AUTOJUMP_SH > $TMP_AUTOJUMP_SH
		mv -f $TMP_AUTOJUMP_SH $SRC_AUTOJUMP_SH
	fi
done
echo "Done"
