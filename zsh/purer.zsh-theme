# Purer...
# An even lighter alternative to https://github.com/sindresorhus/pure

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

PROMPT='${vim_prompt_color}❯ $reset_color'
RPROMPT=''

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX="$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"
