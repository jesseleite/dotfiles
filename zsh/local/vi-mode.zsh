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

# Export prompt color for purer theme
vim_ins_color="$fg[yellow]"
vim_cmd_color="$fg[magenta]"
vim_prompt_color=$vim_ins_color

function zle-keymap-select {
  vim_prompt_color="${${KEYMAP/vicmd/${vim_cmd_color}}/(main|viins)/${vim_ins_color}}"
  zle reset-prompt
}

zle -N zle-keymap-select
  function zle-line-finish {
  vim_prompt_color=$vim_ins_color
}

zle -N zle-line-finish

# Fixing a bug
# Something to do with showing wrong mode
function TRAPINT() {
  vim_prompt_color=$vim_ins_color
  return $(( 128 + $1 ))
}
