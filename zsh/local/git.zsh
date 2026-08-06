# ------------------------------------------------------------------------------
# Git Good 😎
# ------------------------------------------------------------------------------

# Save a precious two characters
alias g='git'

# Clone
alias gcl='git clone'

# Init and create initial commit
alias gin='git init && git add --all && git commit -m "Initial commit"'

# Go to git root, whether in a regular subdir or a worktree subdir
alias groot='cd $(git_root)'

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

# Checkout a PR with fzf fuzzy search
gpr() {
  if $(git_is_using_worktrees); then gwpr $@; return; fi
  if [ -n "$1" ]; then gh pr checkout $1; return; fi
  local selected
  selected=$(
    gh_pretty_list_prs |
      fzf \
        --ghost 'Checkout PR...' \
        --info=hidden \
        --ansi \
        --delimiter=$'\t' \
        --with-nth=2.. \
        --accept-nth=1 \
        --tabstop=2
  ) || return
  [[ -n $selected ]] || return 1
  gh pr checkout "$selected"
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

# Manage stashes with fzf fuzzy search and status or hunk preview
gstl() {
  local preview_files preview_diff selected helpers
  preview_files='git -c color.ui=always stash show --stat --include-untracked {1} 2>/dev/null; echo; git stash show --name-status --include-untracked {1} 2>/dev/null'
  preview_diff='git stash show -p --include-untracked {1} 2>/dev/null | hunk-static'
  helpers=$(functions git_stash_files git_stash_drop git_stash_rename git_pretty_list_stashes)
  selected=$(
    git_pretty_list_stashes |
      fzf \
        --ghost 'Apply stash...' \
        --info=hidden \
        --footer='changes [ctrl-i] · diff [ctrl-o] · rename [ctrl-r] · drop [ctrl-x]' \
        --ansi \
        --no-sort \
        --delimiter=$'\t' \
        --with-nth=2,3 \
        --accept-nth=1 \
        --tabstop=2 \
        --preview-window='right:60%:border-left' \
        --preview-label='files' \
        --preview="$preview_files" \
        --bind="ctrl-i:change-preview($preview_files)+change-preview-label(files)" \
        --bind="ctrl-o:change-preview($preview_diff)+change-preview-label(diff)" \
        --bind="ctrl-r:execute(clear; zsh -c $(printf %q "$helpers; git_stash_rename \"\$1\"") zsh {1})+reload(zsh -c $(printf %q "$helpers; git_pretty_list_stashes"))" \
        --bind="ctrl-x:execute(clear; zsh -c $(printf %q "$helpers; git_stash_drop \"\$1\"") zsh {1})+reload(zsh -c $(printf %q "$helpers; git_pretty_list_stashes"))"
  ) || return
  [[ -n $selected ]] || return 1
  git --no-pager stash apply "$selected"
}


# ------------------------------------------------------------------------------
# Worktree Management
# ------------------------------------------------------------------------------

# Init worktrunk
if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# List worktrees
alias wtl="wt list"

# Create worktree
alias wtc="wt switch -c"

# Switch worktree
alias wts="wt switch"

# Remove worktree
alias wtr="wt remove"

# Create or switch to a PR worktree with fzf fuzzy search
wtpr() {
  if [ -n "$1" ]; then wt switch pr:$1; return; fi
  local selected
  selected=$(
    gh_pretty_list_prs |
      fzf \
      --ghost 'Checkout PR...' \
      --info=hidden \
      --ansi \
      --delimiter=$'\t' \
      --with-nth=2.. \
      --accept-nth=1 \
      --tabstop=2
    ) || return
    [[ -n $selected ]] || return 1
    wt switch pr:$selected
}


# ------------------------------------------------------------------------------
# Helper Funcs
# ------------------------------------------------------------------------------

# Show git root, whether in a regular subdir or a worktree subdir
git_root() {
  git worktree list | awk 'NR==1{ print $1 }'
}

# Check if repo is using worktrees
# Bare: always worktree-driven
# Non-bare (worktrunk default): true once >1 worktree exists
git_is_using_worktrees() {
  local list n
  list=$(git worktree list 2>/dev/null) || return 1
  n=$(print -r -- "$list" | wc -l | tr -d ' ')
  (( n > 1 )) && return 0
  print -r -- "$list" | grep -q '(bare)'
}

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

# List stashes as TSV for fzf
# Fields: stash ref (accept), date, message
git_pretty_list_stashes() {
  git stash list --pretty=format:'%gd%x09%cI%x09%gs' |
    awk -F '\t' '
      {
        split($2, iso, "T")
        date = iso[1]
        msg = $3
        if (msg ~ /^On /) sub(/^On [^:]+: /, "", msg)
        printf "%s\t%s\t%s\t%s\n", $2, $1, date, msg
      }
    ' |
    sort -t$'\t' -k1,1r |
    awk -F '\t' '{ printf "%s\t\033[2m%s\033[0m\t%s\n", $2, $3, $4 }'
}

# Show stash file summary (same as gstl files preview; --no-pager for fzf execute)
git_stash_files() {
  git --no-pager -c color.ui=always stash show --stat --include-untracked "$1" 2>/dev/null
  echo
  git --no-pager stash show --name-status --include-untracked "$1" 2>/dev/null
}

# Delete a given stash
git_stash_drop() {
  local stash=$1
  [[ -n $stash ]] || return 1

  local desc
  desc=$(git stash list --format='%gs' -n 1 "$stash" 2>/dev/null)

  echo "Are you sure you would like to delete the [\e[0;31m$stash\e[0m] stash?"
  [[ -n $desc ]] && echo "\n  $desc"
  echo
  git_stash_files "$stash"
  echo
  echo "(Type 'delete' to confirm)"
  local confirmation
  read confirmation || return 1
  [[ $confirmation == delete ]] || return 1

  git stash drop --quiet "$stash"
}

# Rename a given stash
git_stash_rename() {
  local stash=$1
  [[ -n $stash ]] || return 1

  local desc msg rev
  desc=$(git stash list --format='%gs' -n 1 "$stash" 2>/dev/null)

  echo "Rename [\e[0;31m$stash\e[0m] stash"
  [[ -n $desc ]] && echo "\n  $desc"
  echo
  git_stash_files "$stash"
  echo
  echo -n "New stash message: "
  read msg || return 1
  [[ -n $msg ]] || return 1

  rev=$(git rev-parse "$stash") || return 1
  echo "stash commit: $rev"

  git stash drop --quiet "$stash" || return 1
  git stash store -m "$msg" "$rev" || return 1
}

# List github PRs as TSV for fzf
# Fields: number (accept), #number, title, author, branch, updated
gh_pretty_list_prs() {
  gh pr list \
    --limit 500 \
    --json number,title,author,headRefName,updatedAt \
    --template '{{range .}}{{printf "%v\t%s\t%-60s\t%-15s\t%-40s\t%s\n" .number (printf "#%v" .number | autocolor "green") (truncate 60 .title) (truncate 15 .author.login) (truncate 40 .headRefName) (timeago .updatedAt)}}{{end}}'
}
