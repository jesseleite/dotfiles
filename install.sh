# Ensure ~/.dotfiles exists before running this installer <3

# Hush terminal login.
touch ~/.hushlogin

# Git love.
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.gitignore_global ~/.gitignore_global

# Clone Oh-My-Zsh.
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Copy Robby's .zshrc over as .zshrc-template for reference purposes only.
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc-template

# Copy out .zshrc and theme.
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/an-old-hope.zsh-theme ~/.oh-my-zsh/themes

# Clone Tipz.
git clone https://github.com/molovo/tipz ~/.tipz

# Vim love.
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.vim/UltiSnips ~/.vim/UltiSnips
git clone git://github.com/hchbaw/opp.zsh.git ~/.opp.zsh
cp ~/.dotfiles/.clivimrc ~/.clivimrc

# Ctags love.
ln -s ~/.dotfiles/.ctags.d ~/.ctags.d

# Set default shell.
chsh -s /usr/bin/zsh

# Final message.
echo '*****'
echo 'Done <3 <3 <3'
echo 'Note: You can set up git user via `gituser` alias!'
