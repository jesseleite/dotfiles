# ------------------------------------------------------------------------------
# Aliases and functions for Git
# ------------------------------------------------------------------------------

alias gpom="gl origin master"
alias nah="grhh && gclean"

# Unalias oh-my-zsh aliases, in favour of following functions
unalias gst
unalias gco
unalias gbd

# Git status with fugitive
gst() {
  if [ -n "$1" ]; then
    z $1
  fi

  if git rev-parse --git-dir > /dev/null 2>&1; then
    vim '+Gedit :'
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

# Git delete branch with fzf
gbd() {
  if [ -n "$1" ]; then git branch -d $1; return; fi
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git branch -d $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Checkout PR
gpr() {
    if [ -z "$1" ]; then
        echo "Usage: gpr <pr number> [<local branch name>]"
        return
    fi

    if [ $2 ]; then
        branch=$2
    else
        branch=pr/$1
    fi

    git fetch origin pull/$1/head:$branch
    git checkout $branch
}
