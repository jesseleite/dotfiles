# Ensure ~/.dotfiles exists before running this installer <3

# Clone Oh-My-Zsh.
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Copy Robby's .zshrc over as .zshrc-template for reference purposes only.
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc-template

# Copy out .zshrc and theme.
cp ~/.dotfiles/.zshrc ~/.zshrc
cp ~/.dotfiles/an-old-hope.zsh-theme ~/.oh-my-zsh/themes

# Vim love.
cp ~/.dotfiles/.vimrc ~/.vimrc
git clone git://github.com/hchbaw/opp.zsh.git ~/.opp.zsh
cp ~/.dotfiles/.clivimrc ~/.clivimrc

# Copy out .gitconfig.
cp ~/.dotfiles/.gitconfig ~/.gitconfig

# Set default shell.
chsh -s /usr/bin/zsh

# Final message.
echo '*****'
echo 'Done <3 <3 <3'
echo 'Note: You can set up git user via `gituser` alias!'
