# Install Jenkins 
brew install jenkins-lts

# In my Case Mac M1
arch -x86_64 brew install jenkins-lts

# Uninstall
arch -x86_64 brew uninstall jenkins-lts


# Will start jenkins on port 8080
brew services start jenkins-lts
sudo arch -x86_64 brew services start jenkins-lts

# Restart Jenkins
brew services restart jenkins-lts
sudo arch -x86_64  brew services restart jenkins-lts

# Stop Jenkins
brew services stop jenkins-lts
sudo arch -x86_64 brew services stop jenkins-lts


# Check services status 
brew services list 
sudo arch -x86_64 brew services list 