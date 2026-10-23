# dotfiles

Managed with [chezmoi](https://chezmoi.io). The files that land in `$HOME`
live in `home/` (see `.chezmoiroot`), using chezmoi's naming: `dot_zshrc` is
`~/.zshrc`, `*.tmpl` files are templates, `executable_` sets the exec bit.

## New machine

```sh
# Linux machines get chezmoi from mise via meringue; elsewhere:
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply lancetarn
```

That clones this repo to `~/.local/share/chezmoi` and applies it, which also:

- fetches Oh My Zsh and the forgit plugin (`home/.chezmoiexternal.toml`),
- sets the Claude Code theme once (`home/.chezmoiscripts/`),
- on macOS, installs Homebrew and the `Brewfile`, again whenever it changes.

## Day to day

```sh
chezmoi edit ~/.zshrc     # edit the source, then
chezmoi apply             # write it to $HOME
chezmoi diff              # what apply would change
chezmoi update            # git pull + apply
chezmoi cd                # shell in the source repo, to commit and push
```

Not in `home/`, so chezmoi leaves them alone: `Brewfile` and the
`brew-*.sh` helpers (macOS) and `iterm/` color presets (import by hand).
