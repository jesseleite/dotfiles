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


# ------------------------------------------------------------------------------
# Dynamically set `vi_prompt_color` var (for use in theme.zsh)
# ------------------------------------------------------------------------------

# Export prompt color for my custom theme
local vi_ins_color="$fg[magenta]"
local vi_cmd_color="$fg[yellow]"

# Reset prompt color on line init
function zle-line-init() {
  vi_prompt_color=$vi_ins_color
  zle reset-prompt
}
zle -N zle-line-init

# Update prompt color when keymap / vi mode changes
function zle-keymap-select() {
  vi_prompt_color="${${KEYMAP/vicmd/${vi_cmd_color}}/(main|viins)/${vi_ins_color}}"
  zle reset-prompt
}
zle -N zle-keymap-select

# Reset prompt color on line finish
function zle-line-finish() {
  vi_prompt_color=$vi_ins_color
  zle reset-prompt
}
zle -N zle-line-finish
