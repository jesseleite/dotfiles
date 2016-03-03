# Clone dotfiles.
git clone git://github.com/JesseLeite/dotfiles.git /home/vagrant/.dotfiles

# Update apt-get repo.
apt-get update

# Install ZSH.
apt-get install zsh -y

# Clone Oh-My-Zsh.
git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh

# Copy Robby's .zshrc over as .zshrc-template for reference purposes only.
cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc-template

# Copy out .zshrc and theme.
cp /home/vagrant/.dotfiles/.zshrc /home/vagrant/.zshrc
cp /home/vagrant/.dotfiles/an-old-hope.zsh-theme /home/vagrant/.oh-my-zsh/themes

# Vim love.
cp /home/vagrant/.dotfiles/.vimrc /home/vagrant/.vimrc
git clone git://github.com/hchbaw/opp.zsh.git /home/vagrant/.opp.zsh
cp /home/vagrant/.dotfiles/.clivimrc /home/vagrant/.clivimrc

# Copy out .gitconfig.
cp /home/vagrant/.dotfiles/.gitconfig /home/vagrant/.gitconfig

# Set default shell.
chsh -s /usr/bin/zsh vagrant

# Turn off sendfile, to prevent NFS from sending old and corrupt files.
# Only applies if you are using NFS syncing in Homestead.yaml config.
# More info: http://docs.vagrantup.com/v2/synced-folders/virtualbox.html
sed -i 's/sendfile on;/sendfile off;/' /etc/nginx/nginx.conf

# Increase xdebug max nesting level, to prevent xdebug error while testing.
#sed -i 's/xdebug.max_nesting_level = 250/xdebug.max_nesting_level = 500/' /etc/php5/cli/conf.d/20-xdebug.ini

# Restart services.
service nginx restart
service php5-fpm restart

# Install locale extension.
apt-get install php7.0-intl

# Final message.
echo '*****'
echo 'Done <3 <3 <3'
echo 'Note: You can set up git user via `gituser` alias!'
