set PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin /opt/X11/bin /Library/TeX/texbin /usr/local/share/git-core/contrib/diff-highlight/

# OS-specific settings
if [ (uname) = 'Linux' ]
  set TERM screen-256color-bce
else if [ (uname) = 'Darwin' ]
  function sublime
    /Applications/Sublime\ Text\ 3.app/Contents/MacOS/Sublime\ Text $argv
  end
  function refreshSpotlightIndex
    sudo mdutil -E /
  end
end

# Using Base16-Shell thus we need to do this in order to
# to have a working color scheme for more information see:
# https://github.com/chriskempson/base16-shell
eval sh $HOME/.config/base16-shell/base16-ocean.dark.sh

# Anroid Home
set -x ANDROID_HOME /usr/local/opt/android-sdk

# Colorize grep
alias grep "grep -n --color"

# Little helper alias for SyncMe
alias fhs "pushd .; cd ~/Dropbox/FHNW/SyncMe/SyncMe/; make -i | less; popd; clear"

# run fish in vim mode
fish_vi_mode
