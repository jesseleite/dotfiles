# ------------------------------------------------------------------------------
# Aliases and functions for Git
# ------------------------------------------------------------------------------

# Aliases
alias g='git'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gin='git init && gaa && gcmsg "Initial commit."'
alias gcb='git checkout -b'
alias gdb='git remote show origin | grep "HEAD branch" | cut -d " " -f5'
alias gcod='gco $(gdb)'
alias gaa='git add --all'
alias gcp='git cherry-pick'
alias gc='git commit --verbose'
alias gca='git commit --verbose --amend'
alias gl='git log --oneline --decorate --graph'
alias gsh='git show'
alias gp='git pull'
alias gpom='git pull origin master'
alias gpush='git push'
alias gpsup="git push --set-upstream origin $(git branch --show-current 2> /dev/null)"
alias gpusht='git push --tags'
alias gsta='git stash push'
alias gstaa='git stash apply'
alias glt='git describe --tags --abbrev=0' # git latest tag
alias gcslt='git --no-pager log $(glt)..HEAD --oneline --no-decorate --first-parent --no-merges' # git commits since latest tag
alias changelog='gcslt && gcslt | pbcopy' # copy commits since latest tag for changelog
alias kicktests='git commit --allow-empty -m "Kick test suite."'
alias tower='gittower .'

# Git status with fugitive
gs() {
  if [ -n "$1" ]; then z $1; fi

  if git rev-parse --git-dir > /dev/null 2>&1; then
    $EDITOR '+Gedit :'
  else
    git status
  fi
}

# Git checkout with gum fuzzy search
gco() {
  if [ -n "$1" ]; then git checkout $1; return; fi
  local branches
  branches=$(git branch | awk '{print $1}' | rg -v '\*')
  echo $branches | gum filter --placeholder 'Checkout branch...' | xargs git checkout
}

# Git checkout remote branch with gum fuzzy search
gcr() {
  git fetch
  if [ -n "$1" ]; then git checkout $1; return; fi
  local branches
  branches=$(git branch --all | awk '{print $1}' | rg -v '\*')
  echo $branches | gum filter --placeholder 'Checkout remote branch...' | sed "s#remotes/[^/]*/##" | xargs git checkout
}

# Git checkout history with gum fuzzy search
gch() {
    local history
    history=$(git reflog show --pretty=format:'%gs ~ %gd' --date=relative | grep checkout | grep -oE '[^ ]+ ~ .*' | awk -F~ '!seen[$1]++' | head -n 11 | tail -n 10 | awk -F' ~ HEAD@{' '{printf("%s: %s\n", substr($2, 1, length($2)-1), $1)}')
    echo "$history" | gum filter --placeholder 'Checkout history...' | awk '{print $NF}' | xargs git checkout
}

# Git checkout a PR with gum fuzzy search
gpr() {
  if [ -n "$1" ]; then gh pr checkout $1; return; fi
  local prs=$(gh pr list \
    --json number,title,headRefName,updatedAt \
    --template '{{range .}}{{tablerow (printf "#%v" .number | autocolor "green") (truncate 60 .title) (truncate 40 .headRefName) (timeago .updatedAt)}}{{end}}')
  echo $prs | gum filter --placeholder 'Checkout PR...' | awk '{print $1}' | xargs gh pr checkout
}

# Git checkout tag with gum fuzzy search
gct() {
  if [ -n "$1" ]; then git checkout $1; return; fi
  git tag | gum filter --placeholder 'Checkout tag...' | xargs git checkout
}

# Git delete branch with gum fuzzy search
gbd() {
  if [ -n "$1" ]; then git branch -d $1; return; fi
  local branches
  branches=$(git branch | awk '{print $1}' | rg -v '\*')
  local selected=$(echo $branches | gum filter --placeholder 'Delete branch...')
  if [ -z "$selected" ]; then return; fi
  echo "Are you sure you would like to delete branch [\e[0;31m$selected\e[0m]? (Type 'delete' to confirm)"
  read confirmation
  if [[ "$confirmation" == "delete" ]]; then
    git branch -D $selected
  fi
}

# Commit with message
gcmsg() {
  git commit -m "$*"
}

# Add all and commit with message
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

# TODO: Maybe I want a few of these aliases more back since ditching oh-my-zsh...
# Maybe git submodule and/or worktree stuff?
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
