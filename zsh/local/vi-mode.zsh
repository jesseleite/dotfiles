# ------------------------------------------------------------------------------
# Vi mode config
# ------------------------------------------------------------------------------

# Enable zsh's built-in vi mode
bindkey -v

# Bind `jk` to exit insert mode (esc will still work though)
bindkey -M viins 'jk' vi-cmd-mode

# Set timeout as low as possible for the least amount of delay when pressing `esc`,
# but not so fast that it negatively affects the above `jk` mapping.
export KEYTIMEOUT=10

# Bring back some non-vi defaults
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
