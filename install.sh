# Link and start mysql@5.7 whenever mac starts.
brew link --force mysql@5.7
brew services start mysql@5.7

# If still getting socket errors, follow instructions here:
# https://superuser.com/questions/1333504/brew-install-mysql5-7-cant-connect-to-local-mysql-server-through-socket
