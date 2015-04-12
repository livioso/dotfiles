set PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin /opt/X11/bin /usr/local/MacGPG2/bin /usr/texbin/ /Users/livio/Android/sdk/platform-tools/ /Users/livio/Android/sdk/tools/

# OS-specific settings
if [ (uname) = 'Linux' ]
  set TERM screen-256color-bce
else if [ (uname) = 'Darwin' ]
  function sublime
    /Applications/Sublime\ Text\ 3.app/Contents/MacOS/Sublime\ Text $argv
  end
end

# Using Base16-Shell thus we need to do this in order to
# to have a working color scheme for more information see:
# https://github.com/chriskempson/base16-shell
eval sh $HOME/.config/base16-shell/base16-ocean.dark.sh
