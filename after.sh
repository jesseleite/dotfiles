# Install ZSH.
apt-get install zsh -y

# Clone Oh-My-Zsh.
git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh

# Copy Robby's .zshrc over as .zshrc-robby for reference purposes only.
cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc-robby

# Clone my .zshrc and theme.
git clone git://github.com/JerseyMilker/HomesteadAfter.git /home/vagrant/.homestead-after
cp /home/vagrant/.homestead-after/jersey-homestead.zsh-theme /home/vagrant/.oh-my-zsh/themes
cp /home/vagrant/.homestead-after/.zshrc /home/vagrant/.zshrc

# Clone my .gitconfig.
cp /home/vagrant/.homestead-after/.gitconfig /home/vagrant/.gitconfig
   # Can I grab git user info from host and set, or read user input and set?

# Set default shell.
chsh -s /usr/bin/zsh vagrant

# Final message.
echo 'Done installing HomesteadAfter extras <3'
