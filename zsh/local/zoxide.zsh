# ------------------------------------------------------------------------------
# Zoxide: Smarter `cd` command, spirtual successor to the awesome rupa/z 🔥
# ------------------------------------------------------------------------------

eval "$(zoxide init zsh)"

zsync() {
  zoxide query --list --all \
    | grep "^$(pwd)/" \
    | while read dir; do [ ! -d "$dir" ] && echo "$dir"; done \
    | xargs zoxide remove

  ls -d */ \
    | sed "s|/\$||;s|^|$(pwd)/|" \
    | grep -vxF -f <(zoxide query --list --all) \
    | xargs zoxide add

  echo 'Synced zoxide index for current directory.'
}
