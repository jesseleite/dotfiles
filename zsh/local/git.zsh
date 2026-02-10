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
alias gin='git init && git add --all && git commit -m "Initial commit."'

# Go to git root, whether in a regular subdir or a worktree subdir
alias gr='cd $(git_root)'

# View current PR in browser
alias gprv='gh pr view --web'


# ------------------------------------------------------------------------------
# Branch Management
# ------------------------------------------------------------------------------

# Go to git default branch using z arg
gz() {
  if [ -z "$1" ]; then echo 'Please specify `git worktree add` params!'; return; fi
  z $1
  gcod
}

# List local branches / worktrees
gb() {
  if $(git_is_using_worktrees); then git worktree list; return; fi
  git branch
}

# Push
alias gpsup='git push --set-upstream origin $(git branch --show-current 2> /dev/null)'
alias gpusht='git push --tags'

# Pull
alias gp='git pull'
alias gpom='git pull origin $(git_master_or_main_branch)'
alias gpomr='git pull origin $(git_master_or_main_branch) --rebase'
alias gpod='git pull origin $(git_default_branch)'
alias gpush='git push'

# Checkout default origin branch
alias gcod='gco $(git_default_branch)'

# Checkout branch with gum fuzzy search
gco() {
  if $(git_is_using_worktrees); then gwo $@; return; fi
  if [ -n "$1" ]; then git checkout $1; return; fi
  local branches
  branches=$(git branch | awk '{print $1}' | rg -v '\*')
  echo $branches | gum filter --placeholder 'Checkout local branch...' | xargs git checkout
}

# Add and checkout new branch
gba() {
  if $(git_is_using_worktrees); then gwa $@; return; fi
  git checkout -b $@
}

# Checkout remote branch with gum fuzzy search
gcr() {
  if $(git_is_using_worktrees); then gwr $@; return; fi
  git fetch > /dev/null 2>&1
  if [ -n "$1" ]; then git checkout $1; return; fi
  local branches
  branches=$(git branch --all | awk '{print $1}' | rg -v '\*')
  echo $branches | gum filter --placeholder 'Checkout remote branch...' | sed "s#remotes/[^/]*/##" | xargs git checkout
}

# Checkout a PR with gum fuzzy search
gpr() {
  if $(git_is_using_worktrees); then gwpr $@; return; fi
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
  if $(git_is_using_worktrees); then gwd $@; return; fi
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

# Clean up local branches that have been merged on Github already
# TODO: Disclude git_default_branch (ie. 6.x in seo-pro)
# TODO: Don't do anything if there are unstaged changes
gbc() {
  gcod
  git pull
  local merged
  merged=$(gh pr list --state merged --json headRefName --jq '.[].headRefName' --limit 1000)
  local deleteable=()
  git branch --format='%(refname:short)' | while read branch; do
    echo $merged | grep -q "^$branch$" && deleteable+=("$branch")
  done
  if (( ${#deleteable} == 0 )); then
    echo "No branches to clean!"
    return
  fi
  echo "\nThe following branches were already merged on Github:\n"
  print -l $deleteable
  echo "\nWould you like to delete these branches? (Type 'delete' to confirm)"
  read confirmation
  if [[ "$confirmation" == "delete" ]]; then
    echo
    for branch in $deleteable; do
      git branch -d "$branch"
    done
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
  gl -n 5
}

# Discard all unstaged changes & untracked files to trash bin
# Note: This requires `trash` util so that the files can be restored if needed later
nah() {
  echo "Are you sure you would like to discard/delete all unstaged changes & untracked files? (Type 'y' to confirm)"
  read confirmation
  if [[ "$confirmation" == "y" ]]; then
    git ls-files --modified --other --exclude-standard | xargs trash
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
# Worktree Management
# ------------------------------------------------------------------------------

# Save precious characters
alias gw='git worktree'
alias gwl='git worktree list'

# Use this instead of `mv` on the worktree folder directly, so that they remain linked to the repo
alias gwm='git worktree move'
# TODO: automatically cd in or add new zoxide result too?

# Clone a bare repository for a worktree, and automatically add worktree for default branch
# Note: The `*/.git` path just unclutters the root level of the bare repo
gwcl() {
  if [ -z "$1" ]; then echo 'Please specify repo or path to clone from!'; return; fi
  if [ -z "$2" ]; then
    local dir=$(basename $1 | sed 's#.git##')
  else
    local dir=$2
  fi
  git clone --bare $1 $dir/.git
  cd $dir
  git config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
  gwr $(git_default_branch)
}

# Open an existing local worktree
gwo() {
  if [ -n "$1" ]; then cd $(git_root); cd $1; return; fi
  local selected=$(git worktree list | rg -v 'bare' | gum filter --placeholder 'Open local worktree...' | awk '{ print $1 }')
  if [ -z "$selected" ]; then return; fi
  cd $selected
}

# Add a new worktree, ensuring it gets added at git root
# Note: The cd at the end is important for zoxide/sesh/tmux workflow
gwa() {
  if [ -z "$1" ]; then echo 'Please specify `git worktree add` params!'; return; fi
  cd $(git_root)
  git fetch > /dev/null 2>&1
  local dir=$1
  local branch=$1
  local from_branch
  if [ -n "$2" ]; then
    from_branch=$2
  else
    from_branch=$(git_default_branch)
  fi
  if [ ${#branch} -gt 25 ]; then
    echo "\nThe [\e[0;31m$dir\e[0m] name is a bit long, would you like to use an abbreviated directory name? (y/n, default:n)"
    read confirmation
    if [[ "$confirmation" == "y" ]]; then
      echo "\nEnter a new directory name:"
      read dir
    fi
  fi
  echo
  dir=$(echo $dir | sed 's/\//-/g')
  git worktree add $dir -b $branch $from_branch
  sesh connect $dir
  zsync
  cd -
}

# Add a new worktree from a remote branch with gum fuzzy search, and flatten target folder
gwr() {
  git fetch > /dev/null 2>&1
  if [ -n "$1" ]; then gwa $1; return; fi
  local branches
  branches=$(git branch --all | awk '{print $1}' | rg -v '[\*\+]')
  local selected=$(echo $branches | gum filter --placeholder 'Add worktree from remote branch...' | sed "s#remotes/[^/]*/##")
  if [ -z "$selected" ]; then return; fi
  cd $(git_root)
  local dir=$(echo $selected | sed "s#/#-#")
  gwa $dir $selected
  git branch --set-upstream-to=origin/$selected $selected
}

# Add a new worktree from a PR with gum fuzzy search
gwpr() {
  if [ -z "$1" ]; then
    local pr=$(gh_pretty_list_prs | gum filter --placeholder 'Add worktree from PR...' | awk '{print $1}' | sed "s/#//")
  else
    local pr=$1
  fi
  if [ -z "$pr" ]; then return; fi
  cd $(git_root)
  gwa $pr
  gh pr checkout $pr
}

# Delete a local worktree with gum fuzzy search, and require extra confirmation to prevent accidents
# Note: This requires `trash` util so that the files can be restored if needed later as well
gwd() {
  local selected=$(git worktree list | rg -v 'bare' | gum filter --placeholder 'Remove local worktree...' | awk '{ print $1 }' | xargs basename)
  if [ -z "$selected" ]; then return; fi
  echo "Are you sure you would like to delete the [\e[0;31m$selected\e[0m] worktree? (Type 'delete' to confirm)"
  read confirmation
  if [[ "$confirmation" == "delete" ]]; then
    cd $(git_root)
    cd $selected
    local branch=$(git branch --show-current)
    cd $(git_root)
    echo "\nWould you like to also delete the [\e[0;31m$branch\e[0m] branch? (y/n)"
    read confirmation
    echo
    trash $selected
    git worktree prune
    if [[ "$confirmation" == "y" ]]; then
      git branch -D $branch
    fi
    zsync
  fi
}


# ------------------------------------------------------------------------------
# Helper Funcs
# ------------------------------------------------------------------------------

# Show git root, whether in a regular subdir or a worktree subdir
git_root() {
  git worktree list | awk 'NR==1{ print $1 }'
}

# Check if repo is a bare repo with worktrees
git_is_using_worktrees() {(
  cd $(git_root) && git rev-parse --is-bare-repository
)}

# Show default origin branch
git_default_branch() {
  git remote show origin | grep "HEAD branch" | cut -d " " -f5
}

# Show master or main branch, depending on what the origin repo uses
git_master_or_main_branch() {
  if git ls-remote --exit-code --heads origin main &>/dev/null; then
    echo "main"
  else
    echo "master"
  fi
}

# List github PRs in pretty table format for gum filtering
gh_pretty_list_prs() {
  gh pr list \
    --limit 500 \
    --json number,title,author,headRefName,updatedAt \
    --template '{{range .}}{{tablerow (printf "#%v" .number | autocolor "green") (truncate 60 .title) (truncate 15 .author.login) (truncate 40 .headRefName) (timeago .updatedAt)}}{{end}}'
}
