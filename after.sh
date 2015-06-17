# Install ZSH.
apt-get install zsh -y

# Clone Oh-My-Zsh.
git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh

# Copy Robby's .zshrc over as .zshrc-template for reference purposes only.
cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc-template

# Clone Homestead After files.
git clone git://github.com/JerseyMilker/Homestead-After.git /home/vagrant/.homestead-after

# Copy out .zshrc and theme.
cp /home/vagrant/.homestead-after/.zshrc /home/vagrant/.zshrc
cp /home/vagrant/.homestead-after/jersey-homestead.zsh-theme /home/vagrant/.oh-my-zsh/themes

# Vim love.
cp /home/vagrant/.homestead-after/.vimrc /home/vagrant/.vimrc
git clone git://github.com/hchbaw/opp.zsh.git /home/vagrant/.opp.zsh 
cp /home/vagrant/.homestead-after/.clivimrc /home/vagrant/.clivimrc

# Copy out .gitconfig.
cp /home/vagrant/.homestead-after/.gitconfig /home/vagrant/.gitconfig

# Set default shell.
chsh -s /usr/bin/zsh vagrant

# Ruby and Sass, so I can use csstyle, until libsass gets it's act together.
apt-get install ruby
gem install sass

# Turn off sendfile, to prevent NFS from sending old and corrupt files.
# Only applies if you are using NFS syncing in Homestead.yaml config.
# More info: http://docs.vagrantup.com/v2/synced-folders/virtualbox.html
sed -i 's/sendfile on;/sendfile off;/' /etc/nginx/nginx.conf

# Increase xdebug max nesting level, to prevent xdebug error while testing.
sed -i 's/xdebug.max_nesting_level = 250/xdebug.max_nesting_level = 500/' /etc/php5/cli/conf.d/20-xdebug.ini

# Restart services.
service nginx restart
service php5-fpm restart

# Final message.
echo '*****'
echo 'Done installing HomesteadAfter extras <3'
echo 'Note: Git user has not been set up!'
echo 'You can set up git user via gituser alias.'
