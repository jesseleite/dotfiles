# ------------------------------------------------------------------------------
# Zoxide: Smarter `cd` command, spirtual successor to the awesome rupa/z 🔥
# ------------------------------------------------------------------------------

eval "$(zoxide init zsh)"

zadd() {
  ls -d */ | xargs zoxide add
  echo 'Successfully added directories at current level to zoxide!'
}
