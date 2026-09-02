# Read by EVERY zsh invocation — interactive, login, scripts, and anything
# launched outside a terminal. .zshrc is interactive-only, which is why EDITOR
# used to be empty in `zsh -c ...` and in tools that shell out non-interactively.
#
# Homebrew's shellenv doesn't run until .zprofile, which is sourced AFTER this
# file, so /opt/homebrew/bin is not on PATH yet. A bare `command -v nvim` misses
# it here and would silently fall back to vim, so check the known install paths
# and export an absolute path when the lookup comes up empty.
#
# VISUAL as well: git, fc and most CLIs check VISUAL before EDITOR.
if command -v nvim >/dev/null 2>&1; then
  export EDITOR='nvim'
elif [ -x /opt/homebrew/bin/nvim ]; then
  export EDITOR='/opt/homebrew/bin/nvim'
elif [ -x /usr/local/bin/nvim ]; then
  export EDITOR='/usr/local/bin/nvim'
else
  export EDITOR='vim'
fi
export VISUAL="$EDITOR"
