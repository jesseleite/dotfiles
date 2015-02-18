echo 'Please enter git user.name:'
read gitName
git config --global user.name "$gitName"
echo 'Please enter git user.email:'
read gitEmail
git config --global user.email "$gitEmail"
