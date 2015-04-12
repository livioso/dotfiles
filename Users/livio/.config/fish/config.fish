set PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin /opt/X11/bin /usr/local/MacGPG2/bin /usr/texbin/ /Users/livio/Android/sdk/platform-tools/ /Users/livio/Android/sdk/tools/


# base16 Shell
eval sh .config/base16-shell/base16-ocean.dark.sh

function sublime
	/Applications/Sublime\ Text\ 3.app/Contents/MacOS/Sublime\ Text $argv
end

function refreshSpotlightIndex
  sudo mdutil -E /
end
