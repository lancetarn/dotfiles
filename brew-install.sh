#!/usr/bin/env bash
#
# brew-install.sh — install Homebrew (if needed) and all packages from Brewfile.
#
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

# 1. Install Homebrew if it isn't already present.
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found — installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2. Make `brew` available on this shell (covers Apple Silicon + Intel paths).
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# 3. Install everything declared in the Brewfile.
echo "Installing packages from Brewfile..."
brew bundle --file=Brewfile

echo "Done. Run 'brew bundle cleanup --file=Brewfile' to see anything installed but not in the Brewfile."
