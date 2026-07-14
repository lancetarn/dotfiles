#!/bin/bash
#
# From https://github.com/mathiasbynens/dotfiles/blob/master/bootstrap.sh
cd "$(dirname "${BASH_SOURCE}")"
chmod 0755 .
git submodule init
git submodule update

# Install Oh My Zsh + external plugins BEFORE the rsync. The installer refuses
# to run if ~/.oh-my-zsh already exists, and the rsync would create that dir
# (it carries .oh-my-zsh/custom/git-diff.zsh), so order matters.
function installOhMyZsh() {
	if [ ! -d "$HOME/.oh-my-zsh" ]; then
		echo "Installing Oh My Zsh..."
		# KEEP_ZSHRC: never touch the .zshrc we manage in this repo.
		# RUNZSH/CHSH=no: stay non-interactive (macOS already defaults to zsh).
		RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
			sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	else
		echo "Oh My Zsh already installed; skipping."
	fi

	# External custom plugin (git + direnv are built in; forgit is not).
	forgit_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/forgit"
	if [ ! -d "$forgit_dir" ]; then
		echo "Cloning forgit plugin..."
		git clone --depth 1 https://github.com/wfxr/forgit.git "$forgit_dir"
	else
		echo "forgit plugin already present; skipping."
	fi
}
installOhMyZsh

function doIt() {
	rsync --exclude ".gitmodules" --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av . ~
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt installOhMyZsh

# Install Homebrew + packages from the Brewfile.
read -p "Install Homebrew packages from Brewfile? (y/n) " -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	./brew-install.sh
fi

source ~/.bash_profile
