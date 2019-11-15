# Sets reasonable macOS defaults.

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set a faster key repeat
defaults write NSGlobalDomain InitialKeyRepeat 15
defaults write NSGlobalDomain KeyRepeat 2

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Show Safari Favorites Bar
defaults write com.apple.Safari ShowFavoritesBar -bool true

# Change login shell
sudo echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
sudo chsh -s /usr/local/bin/fish livioso
