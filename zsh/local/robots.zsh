# ------------------------------------------------------------------------------
# Aliases and functions for the robots
# ------------------------------------------------------------------------------

alias oc="opencode"
alias cc="claude"
alias gr="grok"

# Claude code uses this
export PATH="$PATH:$HOME/.local/bin"

# Grok binary (node-independent fallback when mise project node lacks npm -g)
export PATH="$PATH:$HOME/.grok/bin"


# ------------------------------------------------------------------------------
# Hunk
# ------------------------------------------------------------------------------

# Hunk diff (by default) with sidebar + split mode
h() {
  set_terminal_title_with_pwd "hunk"
  hunk "${@:-diff}" --watch --sidebar --mode split
}

# Hunk staged diff with sidebar + split mode
hs() {
  set_terminal_title_with_pwd "hunk --staged"
  hunk diff --watch --sidebar --mode split --staged
}

# Hunk diff all branch changes against PR base (or against passed base)
hall() {
  set_terminal_title_with_pwd "hunk all"
  local remote="$(git_default_remote)"
  local base="${1:-$(gh pr view --json baseRefName -q .baseRefName 2>/dev/null || git_default_branch "$remote")}"
  local merge_base
  git fetch "$remote" && merge_base="$(git merge-base "$remote/$base" HEAD)" || return
  hunk diff "$merge_base" --watch --sidebar --mode split
}
