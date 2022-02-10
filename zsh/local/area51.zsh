# ------------------------------------------------------------------------------
# Experimental Stuff
# ------------------------------------------------------------------------------

# Show my top 15 most used commands in my command history
alias favcmds="history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -15"

# Swap laravel to run tests across versions for laravel upgrades
function swaplaravel() {
  mv vendor vendor-temp
  mv composer.lock composer.lock.temp

  mv vendor-alt vendor
  mv composer.lock.alt composer.lock

  mv vendor-temp vendor-alt
  mv composer.lock.temp composer.lock.alt

  compv laravel/framework
}
