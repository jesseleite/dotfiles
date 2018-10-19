# Open vim with z argument.
v() {
  if [ -n "$1" ]; then
    z $1
  fi

  vim
}
