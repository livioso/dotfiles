# Set a faster key repeat
# defaults read | grep -i 'keyrepeat'
# InitialKeyRepeat = 15;
# KeyRepeat = 2;
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write -g ApplePressAndHoldEnabled -bool false
