# ------------------------------------------------------------------------------
# QMK Helpers
# ------------------------------------------------------------------------------

alias qmkf="qmk flash -kb lily58 -km jesseleite"
alias qmkvia="qmk flash -kb lily58 -km via -e CONVERT_TO=stemcell -e STMC_US=yes -e STMC_IS=yes"


# ------------------------------------------------------------------------------
# ZMK Helpers
# ------------------------------------------------------------------------------

# Build left side
function zmkb() {(
  cd /Users/jesseleite/Code/Keyboards/zmk/app
  west build -p -b nice_nano_v2 -- -DSHIELD=corne_left -DZMK_CONFIG="/Users/jesseleite/Code/Keyboards/zmk-config-corne/config"
)}

# Build right side
function zmkbr() {(
  cd /Users/jesseleite/Code/Keyboards/zmk/app
  west build -p -b nice_nano_v2 -- -DSHIELD=corne_right -DZMK_CONFIG="/Users/jesseleite/Code/Keyboards/zmk-config-corne/config"
)}

# Build settings reset
function zmkbreset() {(
  cd /Users/jesseleite/Code/Keyboards/zmk/app
  west build -p -b nice_nano_v2 -- -DSHIELD=settings_reset -DZMK_CONFIG="/Users/jesseleite/Code/Keyboards/zmk-config-corne/config"
)}

# Flash last build
function zmkf() {(
  cd /Users/jesseleite/Code/Keyboards/zmk/app
  cp ./build/zephyr/zmk.uf2 /Volumes/NICENANO
)}
