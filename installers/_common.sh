#!/bin/bash
# Common helpers for term-tools installers
# Source this at the top of each installer script.

# Detect OS
detect_os() {
	case "$(uname -s)" in
		Linux)  echo "Linux" ;;
		Darwin) echo "Darwin" ;;
		*)      echo "Unknown" ;;
	esac
}

# Detect package manager
detect_pkg_manager() {
	if command -v brew >/dev/null 2>&1; then
		echo "brew"
	elif command -v apt-get >/dev/null 2>&1; then
		echo "apt-get"
	elif command -v dnf >/dev/null 2>&1; then
		echo "dnf"
	else
		echo "unknown"
	fi
}

OS="$(detect_os)"
PKG_MANAGER="$(detect_pkg_manager)"

# Ensure Homebrew is available on macOS
if [ "$OS" = "Darwin" ] && [ "$PKG_MANAGER" != "brew" ]; then
	echo "WARNING: Homebrew is not installed."
	echo "Install it from https://brew.sh:"
	echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
	echo ""
	read -r -p "Continue without Homebrew? [y/N] " response
	case "$response" in
		[yY][eE][sS]|[yY]) ;;
		*) exit 1 ;;
	esac
fi

# Install a package if the command is not already available.
# Usage: pkg_install <command_name> [package_name]
# If package_name is omitted, command_name is used.
pkg_install() {
	local cmd="$1"
	local pkg="${2:-$1}"

	if command -v "$cmd" >/dev/null 2>&1; then
		echo "$cmd: already installed"
		return 0
	fi

	echo "Installing $pkg..."
	case "$PKG_MANAGER" in
		brew)    brew install "$pkg" ;;
		apt-get) sudo apt-get install -y "$pkg" ;;
		dnf)     sudo dnf install -y "$pkg" ;;
		*)
			echo "ERROR: No known package manager to install $pkg"
			return 1
			;;
	esac
}
