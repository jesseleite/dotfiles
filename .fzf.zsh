# Git checkout with fzf.
fco() {
  if [ ! -z "$1" ]; then git checkout $1; return; fi
  local branches branch
  branches=$(git branch -vv)
  branch=$(echo "$branches" | fzf +m)
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Git checkout remote branch with fzf.
fcr() {
  git fetch
  if [ ! -z "$1" ]; then git checkout $1; return; fi
  local branches branch
  branches=$(git branch --all | grep -v HEAD)
  branch=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m)
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Git delete branch with fzf.
fbd() {
  if [ ! -z "$1" ]; then git branch -d $1; return; fi
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git branch -d $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Replace oh-my-zsh aliases.
alias gco="fco"
alias gcr="fcr"
alias gbd="fbd"
