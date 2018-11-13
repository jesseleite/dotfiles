#!/bin/sh

# Step 1: Generate/paste SSH keys.
# Step 2: Clone this repo to ~/.dotfiles.
# Step 3: Sudo run this installer <3

echo "Setting up your Mac..."

# Reinstate the 'anywhere' setting in gatekeeper for apps with unidentified developers.
spctl --master-disable

# Install Brew.
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Brew recipes.
brew update

# Install Brewfile bundle.
brew tap homebrew/bundle
brew bundle

# Link and start mysql@5.7 whenever mac starts.
brew link --force mysql@5.7
brew services start mysql@5.7

# If still getting socket errors, follow instructions here:
# https://superuser.com/questions/1333504/brew-install-mysql5-7-cant-connect-to-local-mysql-server-through-socket

# Configure Git.
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/.gitignore_global ~/.gitignore_global

# Oh-My-Zsh.
rm -rf ~/.oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
rm -rf ~/.zshrc-template
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc-template
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/an-old-hope.zsh-theme ~/.oh-my-zsh/themes

# Set default shell.
echo "$(which zsh)" >> /etc/shells
chsh -s $(which zsh)

# Configure Hyper.
ln -sf ~/.dotfiles/.hyper.js ~/.hyper.js
ln -sf ~/.dotfiles/.hyper.css ~/.hyper.css

# Install Tipz.
rm -rf ~/.tipz
git clone https://github.com/molovo/tipz ~/.tipz

# Configure Vim.
ln -sf ~/.dotfiles/.vi-mode.zsh ~/.vi-mode.zsh
ln -sf ~/.dotfiles/vim/vimrc ~/.vimrc
ln -sf ~/.dotfiles/vim/snippets ~/.vim/UltiSnips
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Configure Ctags.
ln -sf ~/.dotfiles/.ctags.d ~/.ctags.d

# Install and configure Valet.
composer global require laravel/valet
valet install
mkdir ~/Code
valet park ~/Code

# Install other installers.
composer global require laravel/installer
composer global require tightenco/lambo
composer global require statamic/cli

# Hush terminal login.
touch ~/.hushlogin

# Heyo!
echo '*****'
echo 'Done <3 <3 <3'
