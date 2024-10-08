# ------------------------------------------------------------------------------
# General theme config
# ------------------------------------------------------------------------------

ZSH_THEME_TERM_TITLE_IDLE="%~"


# ------------------------------------------------------------------------------
# Prompt theme config (inspired by sindresorhus/pure, starship, etc.)
# ------------------------------------------------------------------------------

NEWLINE=$'\n'

function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function get_pwd() {
    print -D $PWD
}

function precmd() {
    print -rP '${NEWLINE}$fg[blue]$(get_pwd) $(git_prompt_info)'
}

PROMPT='${vi_prompt_color}❱ $reset_color'
RPROMPT=''

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX="$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[magenta]"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"
