# ------------------------------------------------------------------------------
# Fzf Default Opts
# ------------------------------------------------------------------------------

local fzf_default_opts=(
  '--preview-window right:50%:noborder:hidden'
  '--color "preview-bg:234"'
  '--bind "alt-p:toggle-preview"'
  '--color "prompt:green,header:grey,spinner:grey,info:grey,hl:blue,hl+:blue,pointer:red"'
)

export FZF_DEFAULT_OPTS="${fzf_default_opts[*]}"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND


# ------------------------------------------------------------------------------
# Installer generated config completion, keybindings, etc.
# ------------------------------------------------------------------------------

# Setup fzf
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"


# ------------------------------------------------------------------------------
# Custom keybindings
# ------------------------------------------------------------------------------

bindkey '^F' fzf-file-widget
