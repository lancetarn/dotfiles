# git-diff.zsh — quick structural diff helpers.
#
# `git diff` is wired to difftastic (diff.external = difft in ~/.gitconfig),
# so everything below renders as a structural side-by-side diff.
#
# Names avoid the omz `git`/`forgit` plugins, which already take
# gd, gdca, gdcw, gds, gdt, gdup, gdw.
#
# Each helper takes an optional first positional arg, then forwards any
# remaining args straight to `git diff` (paths, --stat, -w, etc.):
#   gdm feature --stat
#   gdn 3 -- some/file.rs

# Resolve the repo's main branch (main/master/trunk/…). Reuse omz's resolver
# when the git plugin is loaded, else sniff local refs, defaulting to main.
_gd_main_branch() {
  if typeset -f git_main_branch >/dev/null 2>&1; then
    git_main_branch
    return
  fi
  local b
  for b in main master trunk; do
    git show-ref --quiet --verify "refs/heads/$b" && { echo "$b"; return; }
  done
  echo main
}

# gdm [branch] [git-diff-args…] — what a branch ADDS relative to main, i.e.
# changes since it forked (three-dot / merge-base — the PR-review view).
#   gdm            → current branch vs local main
#   gdm feature-x  → feature-x   vs local main
gdm() {
  local main branch=HEAD
  main=$(_gd_main_branch)
  if [[ -n $1 && $1 != -* ]]; then branch=$1; shift; fi
  git diff "${main}...${branch}" "$@"
}

# gdmo [branch] [git-diff-args…] — same, but against the REMOTE tip
# origin/<main>, so you compare against the latest pushed main.
# Run `git fetch` first for an up-to-date origin.
gdmo() {
  local main branch=HEAD
  main=$(_gd_main_branch)
  if [[ -n $1 && $1 != -* ]]; then branch=$1; shift; fi
  git diff "origin/${main}...${branch}" "$@"
}

# gdmf [branch] [git-diff-args…] — full two-dot diff between main's tip and the
# branch (also shows what changed on main since the fork). Use when you want
# the total difference, not just what the branch added.
gdmf() {
  local main branch=HEAD
  main=$(_gd_main_branch)
  if [[ -n $1 && $1 != -* ]]; then branch=$1; shift; fi
  git diff "${main}..${branch}" "$@"
}

# gdn [N] [git-diff-args…] — current HEAD against N commits back (default 1,
# i.e. HEAD^). Shows the cumulative change of the last N commits.
#   gdn        → git diff HEAD~1 HEAD   (the last commit)
#   gdn 3      → git diff HEAD~3 HEAD   (the last three)
gdn() {
  local n=1
  if [[ -n $1 && $1 != -* ]]; then n=$1; shift; fi
  git diff "HEAD~${n}" HEAD "$@"
}
