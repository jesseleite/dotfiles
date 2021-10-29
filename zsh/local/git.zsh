# ------------------------------------------------------------------------------
# Aliases and functions for Git
# ------------------------------------------------------------------------------

alias gpom="gl origin master"
alias nah="grhh && gclean"
alias gin="git init && gaa && gcmsg 'Initial commit.'"
alias tower="gittower ."
alias gdb='git remote show origin | grep "HEAD branch" | cut -d " " -f5'
alias gcod='gco $(gdb)'
alias gpr='gh pr checkout'

# Unalias oh-my-zsh aliases, in favour of following functions
unalias gst
unalias gco
unalias gbd
unalias gcmsg
unalias gcam

# Git status with fugitive
gst() {
  if [ -n "$1" ]; then
    z $1
  fi

  if git rev-parse --git-dir > /dev/null 2>&1; then
    $EDITOR '+Gedit :'
  else
    git status
  fi
}

# Git checkout with fzf
gco() {
  if [ -n "$1" ]; then git checkout $1; return; fi
  local branches branch
  branches=$(git branch -vv)
  branch=$(echo "$branches" | fzf +m)
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Git checkout remote branch with fzf
gcr() {
  git fetch
  if [ -n "$1" ]; then git checkout $1; return; fi
  local branches branch
  branches=$(git branch --all | grep -v HEAD)
  branch=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m)
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Git checkout tag with fzf
gct() {
  if [ -n "$1" ]; then git checkout $1; return; fi
  local tags tag
  tags=$(git tag)
  tag=$(echo "$tags" | fzf +m)
  git checkout $tag
}

# Git delete branch with fzf
gbd() {
  if [ -n "$1" ]; then git branch -d $1; return; fi
  local branches branch selected
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  selected=$(echo "$branch" | awk '{print $1}' | sed "s/.* //")
  echo "Are you sure you would like to delete branch [$selected]? (Type 'delete' to confirm)"
  read confirmation
  if [[ "$confirmation" == "delete" ]]; then
    git branch -D $selected
  else
    echo "Aborted"
  fi
}

# Commit with message
# Note: Oh-my-zsh has this alias already, but this function removes the need to wrap the message in quotes.
gcmsg() {
  git commit -m "$*"
}

# Add all and commit with message
# Note: Oh-my-zsh has this alias already, but it doesn't add untracked files.
gcam() {
  git add --all && git commit -m "$*"
}

# Add all and stash with message
gstam() {
  git add --all && git stash push -m "$*"
}

# Undo last commit and tip of branch
# TODO: If a number arg is passed, undo that many commits at once
gundo() {
  git reset HEAD^
  echo "\nRecent commits:"
  glog -n 5
}
