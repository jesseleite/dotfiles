# ------------------------------------------------------------------------------
# Keyboard flashing helpers
# ------------------------------------------------------------------------------

alias qmkf="qmk flash -kb lily58 -km jesseleite"
alias qmkvia="qmk flash -kb lily58 -km via -e CONVERT_TO=stemcell -e STMC_US=yes -e STMC_IS=yes"

function zmkb() {(
  cd /Users/jesseleite/Code/Keyboards/zmk/app
  west build -p -b nice_nano_v2 -- -DSHIELD=corne_left -DZMK_CONFIG="/Users/jesseleite/Code/Keyboards/zmk-config-corne/config"
)}

function zmkf() {(
  cd /Users/jesseleite/Code/Keyboards/zmk/app
  cp ./build/zephyr/zmk.uf2 /Volumes/NICENANO
)}
