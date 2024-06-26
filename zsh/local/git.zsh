# ------------------------------------------------------------------------------
# Aliases and functions for Git
# ------------------------------------------------------------------------------

# Unalias oh-my-zsh aliases, in favour of my own custom config
unalias gco
unalias gbd
unalias gcmsg
unalias gcam
unalias gpr
unalias gp
unalias gstp

# Aliases
alias gin="git init && gaa && gcmsg 'Initial commit.'"
alias tower="gittower ."
alias gdb='git remote show origin | grep "HEAD branch" | cut -d " " -f5'
alias gcod='gco $(gdb)'
alias gpush="git push"
alias gpom="gl origin master"
alias glogs="git log -S"
alias glt='git describe --tags --abbrev=0' # git latest tag
alias gcslt='git --no-pager log $(glt)..HEAD --oneline --no-decorate --first-parent --no-merges' # git commits since latest tag
alias changelog='gcslt && gcslt | pbcopy' # copy commits since latest tag for changelog
alias kicktests='git commit --allow-empty -m "Kick test suite."'

# Git status with fugitive
gs() {
  if [ -n "$1" ]; then z $1; fi

  if git rev-parse --git-dir > /dev/null 2>&1; then
    $EDITOR '+Gedit :'
  else
    git status
  fi
}

# Git checkout with fzf fuzzy search
gco() {
  if [ -n "$1" ]; then git checkout $1; return; fi
  git branch -vv | fzf | awk '{print $1}' | xargs git checkout
}

# Git checkout remote branch with fzf fuzzy search
gcr() {
  git fetch
  if [ -n "$1" ]; then git checkout $1; return; fi
  git branch --all | fzf | sed "s#remotes/[^/]*/##" | xargs git checkout
}

# Git checkout history with fzf fuzzy search
gch() {
    local branches branch
    branches=$(git reflog show --pretty=format:'%gs ~ %gd' --date=relative | grep checkout | grep -oE '[^ ]+ ~ .*' | awk -F~ '!seen[$1]++' | head -n 11 | tail -n 10 | awk -F' ~ HEAD@{' '{printf("%s: %s\n", substr($2, 1, length($2)-1), $1)}')
    selection=$(echo "$branches" | fzf +m)
    branch=$(echo "$selection" | awk '{print $NF}')
    git checkout $branch
}

# Git checkout a PR with fzf fuzzy search
gpr() {
  if [ -n "$1" ]; then gh pr checkout $1; return; fi
  gh pr list | fzf | awk '{print $1}' | xargs gh pr checkout
}

# Git checkout tag with fzf fuzzy search
gct() {
  if [ -n "$1" ]; then git checkout $1; return; fi
  git tag | fzf | xargs git checkout
}

# Git delete branch with fzf fuzzy search
gbd() {
  if [ -n "$1" ]; then git branch -d $1; return; fi
  local selected=$(git branch -vv | fzf | awk '{print $1}' | sed "s/.* //")
  if [ -z "$selected" ]; then return; fi
  echo "Are you sure you would like to delete branch [\e[0;31m$selected\e[0m]? (Type 'delete' to confirm)"
  read confirmation
  if [[ "$confirmation" == "delete" ]]; then
    git branch -D $selected
  fi
}

# Commit with message
# Note: Oh-my-zsh has this alias already, but this function removes the need to wrap the message in quotes
gcmsg() {
  git commit -m "$*"
}

# Add all and commit with message
# Note: Oh-my-zsh has this alias already, but it doesn't add untracked files
gcam() {
  git add --all && git commit -m "$*"
}

# Add all and stash with message
gstam() {
  git add --all && git stash push -m "$*"
}

# Add all and backup to stash with message
gstab() {
  git add --all && git stash push -m "$*" && git stash apply
}

# Undo last commit and tip of branch
# Optionally pass param to specify number of commits to undo (ie. `gundo 3`)
gundo() {
  if [ -n "$1" ]; then
    git reset HEAD~$1
  else
    git reset HEAD~1
  fi
  echo "\nRecent commits:"
  glog -n 5
}

# Discard all unstaged changes & untracked files to trash bin
# Note: This requires `trash` util so that the files can be restored if needed later
nah() {
  echo "Are you sure you would like to discard/delete all unstaged changes & untracked files? (Type 'y' to confirm)"
  read confirmation
  if [[ "$confirmation" == "y" ]]; then
    git ls-files --modified --other --exclude-standard | xargs trash -rf
    git reset --hard
    git clean -qf
  fi
}
