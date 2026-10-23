#!/bin/bash
#
# Default Claude Code theme. The theme files come from dot_claude/themes, but
# settings.json is not tracked (it holds machine-specific hooks and
# permissions), so set just the one key in place. Runs once per machine.
set -euo pipefail

settings="$HOME/.claude/settings.json"
theme="custom:gruvbox-light"

if ! command -v jq >/dev/null; then
	echo "jq not found; skipping Claude Code theme. Set it with /theme."
	exit 0
fi
[ -f "$settings" ] || echo '{}' > "$settings"
jq --arg t "$theme" '.theme = $t' "$settings" > "$settings.tmp" && mv "$settings.tmp" "$settings"
echo "Claude Code theme set to $theme."
