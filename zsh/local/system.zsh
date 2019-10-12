# Edit specific config files.
alias zshrc="z dot && vim ./zsh/zshrc"
alias hyperjs="z dot && vim ./hyper/hyper.js"
alias hypercss="z dot && vim ./hyper/hyper.css"
alias vimrc="z dot && vim ./vim/vimrc"
alias vmap="z dot && vim ./vim/mappings.vim"
alias vplug="z dot && vim ./vim/plugins.vim"
alias gitconfig="z dot && vim ./git/gitconfig"

# Configure git user.
alias gituser="bash ~/.dotfiles/git/user.sh"

# Edit hosts file.
alias hosts="sudo vim /etc/hosts"

# Get ip.
alias ip="curl icanhazip.com"

# Copy SSH key.
alias sshkey="cat ~/.ssh/id_rsa.pub | pbcopy && echo 'Copied SSH key to clipboard 🔑'"

# Search aliases.
function alg() { alias | ag "$*" }
