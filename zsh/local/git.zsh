# ------------------------------------------------------------------------------
# Git Good 😎
# ------------------------------------------------------------------------------

# Save a precious two characters
alias g='git'

# Don't judge me
alias tower='gittower .'

# Clone
alias gcl='git clone'

# Init and create initial commit
alias gin='git init && gaa && gcmsg "Initial commit."'


# ------------------------------------------------------------------------------
# Branch Management
# ------------------------------------------------------------------------------

# List local branches
alias gb="git branch"

# Push
alias gpsup='git push --set-upstream origin $(git branch --show-current 2> /dev/null)'
alias gpusht='git push --tags'

# Pull
alias gp='git pull'
alias gpom='git pull origin master'
alias gpod='git pull origin $(git_default_branch)'
alias gpush='git push'

# Checkout default origin branch
alias gcod='gco $(git_default_branch)'

# Checkout branch with gum fuzzy search
gco() {
  if [ -n "$1" ]; then git checkout $1; return; fi
  local branches
  branches=$(git branch | awk '{print $1}' | rg -v '\*')
  echo $branches | gum filter --placeholder 'Checkout local branch...' | xargs git checkout
}

# Add and checkout new branch
gba() {
  git checkout -b $@
}

# Checkout remote branch with gum fuzzy search
gcr() {
  git fetch
  if [ -n "$1" ]; then git checkout $1; return; fi
  local branches
  branches=$(git branch --all | awk '{print $1}' | rg -v '\*')
  echo $branches | gum filter --placeholder 'Checkout remote branch...' | sed "s#remotes/[^/]*/##" | xargs git checkout
}

# Checkout a PR with gum fuzzy search
gpr() {
  if [ -n "$1" ]; then gh pr checkout $1; return; fi
  gh_pretty_list_prs | gum filter --placeholder 'Checkout PR...' | awk '{print $1}' | sed "s/#//" | xargs gh pr checkout
}

# Checkout tag with gum fuzzy search
gct() {
  if [ -n "$1" ]; then git checkout $1; return; fi
  git tag | gum filter --placeholder 'Checkout tag...' | xargs git checkout
}

# Checkout history with gum fuzzy search
gch() {
  local history
  history=$(git reflog show --pretty=format:'%gs ~ %gd' --date=relative | grep checkout | grep -oE '[^ ]+ ~ .*' | awk -F~ '!seen[$1]++' | head -n 11 | tail -n 10 | awk -F' ~ HEAD@{' '{printf("%s: %s\n", substr($2, 1, length($2)-1), $1)}')
  echo "$history" | gum filter --placeholder 'Checkout history...' | awk '{print $NF}' | xargs git checkout
}

# Delete local branch with gum fuzzy search, and require extra confirmation to prevent accidents
gbd() {
  if [ -n "$1" ]; then git branch -d $1; return; fi
  local branches
  branches=$(git branch | awk '{print $1}' | rg -v '\*')
  local selected=$(echo $branches | gum filter --placeholder 'Delete branch...')
  if [ -z "$selected" ]; then return; fi
  echo "Are you sure you would like to delete the [\e[0;31m$selected\e[0m] branch? (Type 'delete' to confirm)"
  read confirmation
  if [[ "$confirmation" == "delete" ]]; then
    git branch -D $selected
  fi
}


# ------------------------------------------------------------------------------
# Staging Area & Commit Management
# ------------------------------------------------------------------------------

# Git status with fugitive
gs() {
  if [ -n "$1" ]; then z $1; fi

  if git rev-parse --git-dir > /dev/null 2>&1; then
    $EDITOR '+Gedit :'
  else
    git status
  fi
}

# Log
alias gl='git log --oneline --decorate --graph'

# Show
alias gsh='git show'

# Add
alias ga='git add'
alias gaa='git add --all'

# Commit
alias gc='git commit --verbose'
alias gca='git commit --verbose --amend'

# Cherry-pick commit
alias gcp='git cherry-pick'

# Add all and commit with message
gcam() {
  git add --all && git commit -m "$*"
}

# Undo last commit(s)
# Optionally pass param to specify number of commits to undo (ie. `gundo 3`)
# Note: What is undone will be remain as unstaged changes
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

# Latest tag
alias glt='git describe --tags --abbrev=0'

# Log since latest tag
alias gcslt='git --no-pager log $(glt)..HEAD --oneline --no-decorate --first-parent --no-merges'

# Empty commit to kick test suite
alias kicktests='git commit --allow-empty -m "Kick test suite."'


# ------------------------------------------------------------------------------
# Stash Management
# ------------------------------------------------------------------------------

# Stash
alias gsta='git stash push'
alias gstaa='git stash apply'

# Add all and stash with message
gstam() {
  git add --all && git stash push -m "$*"
}

# Add all and backup to stash with message
gstab() {
  git add --all && git stash push -m "$*" && git stash apply
}


# ------------------------------------------------------------------------------
# Helper Funcs
# ------------------------------------------------------------------------------

# Show default origin branch
git_default_branch() {
  git remote show origin | grep "HEAD branch" | cut -d " " -f5
}

# List github PRs in pretty table format for gum filtering
gh_pretty_list_prs() {
  gh pr list \
    --json number,title,headRefName,updatedAt \
    --template '{{range .}}{{tablerow (printf "#%v" .number | autocolor "green") (truncate 60 .title) (truncate 40 .headRefName) (timeago .updatedAt)}}{{end}}'
}
