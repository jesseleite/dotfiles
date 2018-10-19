# Open vim with z argument.
v() {
  if [ ! -z "$1" ]; then z $1; vim; return; fi
  vim
}
