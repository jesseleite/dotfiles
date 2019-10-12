# Open shtuff receiving shell for tests with z argument.
st() {
  if [ -n "$1" ]; then
    z $1
  fi

  shtuff as test
}
