# ------------------------------------------------------------------------------
# Aliases and functions for MacOS
# ------------------------------------------------------------------------------

# Compile karabiner.edn directly from dotfiles
export GOKU_EDN_CONFIG_FILE=$HOME/.dotfiles/karabiner/karabiner.edn

alias hideall="defaults write com.apple.finder AppleShowAllFiles 0 && killall Finder"
alias showall="defaults write com.apple.finder AppleShowAllFiles 1 && killall Finder"
alias hidedesktop="defaults write com.apple.finder CreateDesktop false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop true && killall Finder"

# Run command using Rosetta 2 to emulate x86 environment
rosie() {
  arch -x86_64 $@
}
