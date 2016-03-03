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

# Vim love.
export EDITOR='vim'
source ~/.clivimrc

# Z love.
source ~/z.sh

# Export path.
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

# Aliases.
alias zshrc="sudo vim ~/.zshrc"
alias vimrc="sudo vim ~/.vimrc"
alias gitconfig="sudo vim ~/.gitconfig"
alias gituser="bash ~/.dotfiles/gituser.sh"
alias c="clear"
alias comp="composer"
alias art="php artisan"
alias artc="art clear-compiled && art cache:clear && art route:clear && art config:clear && comp du"
alias artm="art migrate:refresh --seed"
alias hosts="sudo vim /etc/hosts"
alias hs='function __homestead() { (cd ~/Homestead && vagrant $*); unset -f __homestead; }; __homestead'
alias hse="atom ~/.homestead/Homestead.yaml"
alias psr1="php-cs-fixer fix --level=psr1"
alias psr2="php-cs-fixer fix --level=psr2"

# OSX Specific Aliases.
alias hideall="defaults write com.apple.finder AppleShowAllFiles 0 && killall Finder"
alias showall="defaults write com.apple.finder AppleShowAllFiles 1 && killall Finder"
alias hidedesktop="defaults write com.apple.finder CreateDesktop false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop true && killall Finder"

# Project Specific Aliases.
alias artmrr="artm && art db:seed --class=FakeDataSeeder"
