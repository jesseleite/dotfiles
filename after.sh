# Install ZSH.
apt-get install zsh -y

# Clone Oh-My-Zsh.
git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh

# Copy Robby's .zshrc over as .zshrc-template for reference purposes only.
cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc-template

# Clone HomesteadAfter files.
git clone git://github.com/JerseyMilker/HomesteadAfter.git /home/vagrant/.homestead-after

# Copy out .zshrc and theme.
cp /home/vagrant/.homestead-after/.zshrc /home/vagrant/.zshrc
cp /home/vagrant/.homestead-after/jersey-homestead.zsh-theme /home/vagrant/.oh-my-zsh/themes

# Vim love.
cp /home/vagrant/.homestead-after/.vimrc /home/vagrant/.vimrc
git clone https://github.com/hchbaw/opp.zsh.git /home/vagrant
mv /home/vagrant/opp.zsh /home/vagrant/.opp.zsh
cp /home/vagrant/.homestead-after/.clivimrc /home/vagrant/.clivimrc

# Copy out .gitconfig and setup git user.
cp /home/vagrant/.homestead-after/.gitconfig /home/vagrant/.gitconfig
#git config --global user.name "John Madden"
#git config --global user.email "john@example.com"

# Set default shell.
chsh -s /usr/bin/zsh vagrant

# Final message.
echo '*****'
echo 'Done installing HomesteadAfter extras <3'
echo 'Note: Git user has not been set up!'
echo 'You can set up git user via gituser alias.'
