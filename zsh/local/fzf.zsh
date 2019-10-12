# ------------------------------------------------------------------------------
# Fzf Config
# ------------------------------------------------------------------------------

FZF_DEFAULT_COMMAND='ag -u -g ""'
FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND


# ------------------------------------------------------------------------------
# Fzf Installer Generated Config
# ------------------------------------------------------------------------------

# Setup fzf
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Auto-completion
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
