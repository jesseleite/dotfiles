# ------------------------------------------------------------------------------
# Zoxide: Smarter `cd` command, spirtual successor to the awesome rupa/z 🔥
# ------------------------------------------------------------------------------

export _ZO_RESOLVE_SYMLINKS=1

eval "$(zoxide init zsh)"

zadd() {
  ls -d */ | xargs zoxide add
  echo 'Successfully added directories at current level to zoxide!'
}
