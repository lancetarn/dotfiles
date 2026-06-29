#!/usr/bin/env bash
#
# brew-dump.sh — regenerate the list of packages in Brewfile.dump.
#
# This writes a *complete* snapshot (every installed formula + cask + tap,
# including transitive dependencies) to Brewfile.dump. Use it to see exactly
# what is on the machine. The hand-curated `Brewfile` is what you should edit
# and commit for reinstalls; this dump is a reference / diffing aid.
#
# To see just the packages you installed directly (not pulled in as deps):
#   brew leaves --installed-on-request
#
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Install it first (see bootstrap.sh)." >&2
  exit 1
fi

echo "Writing full snapshot to Brewfile.dump ..."
brew bundle dump --file=Brewfile.dump --force

echo
echo "Directly-installed formulae (brew leaves --installed-on-request):"
brew leaves --installed-on-request
echo
echo "Casks:"
brew list --cask
echo
echo "Done. Edit ./Brewfile to add/remove packages for fresh-machine installs."
