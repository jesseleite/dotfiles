# Put this script in your global .homestead folder.
# Homestead uses this script after provisioning.

# Install ZSH.
apt-get install zsh -y

# Clone Oh-My-Zsh.
git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh

# Copy Robby's .zshrc template over.
cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc-robby

# Clone my .zshrc and theme.
git clone git://github.com/JerseyMilker/HomesteadAfter.git /home/vagrant/.homestead-after
cp /home/vagrant/.homestead-after/jersey.zsh-theme /home/vagrant/.oh-my-zsh/themes
cp /home/vagrant/.homestead-after/.zshrc /home/vagrant/.zshrc

# Set default shell.
chsh -s /usr/bin/zsh vagrant
