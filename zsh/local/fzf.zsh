# ------------------------------------------------------------------------------
# Fzf Config
# ------------------------------------------------------------------------------

export FZF_DEFAULT_COMMAND='ag -u -g ""'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS='--preview-window right:50%:noborder:hidden --color "preview-bg:234" --bind "alt-p:toggle-preview"'


# ------------------------------------------------------------------------------
# Fzf Installer Generated Config
# ------------------------------------------------------------------------------

# Setup fzf
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
