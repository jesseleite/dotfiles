# ------------------------------------------------------------------------------
# Aliases and functions for system configuration
# ------------------------------------------------------------------------------

# Configure git user
alias gituser="bash $DOTFILES/git/user.sh"

# Edit hosts file
alias hosts="sudo vim /etc/hosts"

# Get ip
alias ip="curl icanhazip.com"

# Copy SSH key
alias sshkey="cat ~/.ssh/id_rsa.pub | pbcopy && echo 'Copied SSH key to clipboard 🔑'"
