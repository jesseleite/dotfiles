# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="jersey"

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

# Export Path
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

# Aliases
alias zshconfig="vim ~/.zshrc"
alias gitconfig="vim ~/.gitconfig"
alias c="clear"
alias comp="composer"
alias art="php artisan"

# OSX Specific Aliases
alias hs="homestead"
alias hideall="defaults write com.apple.finder AppleShowAllFiles 0 && killall Finder"
alias showall="defaults write com.apple.finder AppleShowAllFiles 1 && killall Finder"

