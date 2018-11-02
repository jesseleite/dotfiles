# Vi Mode Enable
bindkey -v

# Rebind command mode to jk instead of ESC
bindkey -M viins 'jk' vi-cmd-mode

# Set timeout suitable for above binding
export KEYTIMEOUT=300

# Bring back some defaults
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Show mode
vim_ins_mode=''
vim_cmd_mode='vi-mode'
vim_mode=$vim_ins_mode
function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select
  function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# Fixing a bug
# Something to do with showing wrong mode
function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}
