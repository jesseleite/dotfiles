# ------------------------------------------------------------------------------
# Fzf Default Opts
# ------------------------------------------------------------------------------

local fzf_default_opts=(
  '--reverse'
  '--no-separator'
  '--pointer "•"'
  '--scrollbar "█"'
  '--preview-window right:50%:noborder:hidden'
  '--bind "alt-p:toggle-preview"'
  '--bind "ctrl-d:preview-half-page-down"'
  '--bind "ctrl-u:preview-half-page-up"'
  '--color "prompt:green,header:grey,spinner:grey,info:grey,bg+:-1,hl:green,hl+:green,pointer:magenta,preview-bg:-1"'
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
