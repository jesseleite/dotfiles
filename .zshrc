# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="an-old-hope"
export THEME_COMPUTER='X-Wing'
export THEME_PROMPT='R2-D2::'

# Other misc settings.
CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder
plugins=(git)
source $ZSH/oh-my-zsh.sh
# export LANG=en_US.UTF-8
# export ARCHFLAGS="-arch x86_64"
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Tipz love.
source ~/.tipz/tipz.zsh
TIPZ_TEXT='🔥 '

# Z love.
source /usr/local/etc/profile.d/z.sh

# Vim love.
export EDITOR='vim'
source ~/.clivimrc

#Fzf love.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -a --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND='ag -a --hidden --ignore .git -g ""'

# Wat love.
eval "$(thefuck --alias wat)"

# Nvm love.
export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

# Export paths.
export PATH=${PATH}:/bin
export PATH=${PATH}:/usr/bin
export PATH=${PATH}:/usr/local/bin
export PATH=${PATH}:/sbin
export PATH=${PATH}:/usr/sbin
export PATH=${PATH}:/usr/local/sbin
export PATH=${PATH}:/usr/local/git/bin
export PATH=${PATH}:~/.composer/vendor/bin
export PATH=${PATH}:/home/vagrant/bin
export PATH=${PATH}:vendor/bin

# System Aliases.
alias ip="curl icanhazip.com"

# Config Aliases.
alias zshrc="sudo vim ~/.zshrc"
alias hyperjs="sudo vim ~/.hyper.js"
alias hypercss="sudo vim ~/.hyper.css"
alias so="source ~/.zshrc"
alias vimrc="sudo vim ~/.vimrc"
alias gitconfig="sudo vim ~/.gitconfig"
alias gituser="bash ~/.dotfiles/gituser.sh"
alias hosts="sudo vim /etc/hosts"
alias hse="sudo vim ~/.homestead/Homestead.yaml"

# Workflow Aliases.
alias c="clear"
alias a.="atom ."
alias t="phpunit"
function sync() { gf; gl; if [ $(git rev-parse --abbrev-ref HEAD) != "master" ]; then gp; fi; }
alias gpom="gl origin master"
alias nah="grhh && gclean"
alias tags="ctags -R"
alias comp="composer"
function hs() { ( cd ~/Homestead && vagrant $* ) }
alias art="php artisan"
alias artc="art clear-compiled && art cache:clear && art route:clear && art config:clear && art view:clear && comp du"
alias artm="art migrate:refresh --seed"
alias tink="art tinker"
alias ting="art tinker ting.php"
alias dusk="art dusk"
alias ldocs="open http://laravel.com/docs"
alias psr1="php-cs-fixer fix --level=psr1"
alias psr2="php-cs-fixer fix --level=psr2"

# MacOS Aliases.
alias hideall="defaults write com.apple.finder AppleShowAllFiles 0 && killall Finder"
alias showall="defaults write com.apple.finder AppleShowAllFiles 1 && killall Finder"
alias hidedesktop="defaults write com.apple.finder CreateDesktop false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop true && killall Finder"

# RR Aliases.
source ~/.rr

# Ting Goes Pop.
source ~/.ting

