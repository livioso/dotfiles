# path settings
set PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin /opt/X11/bin /Library/TeX/texbin /usr/local/share/git-core/contrib/diff-highlight/

# environment variables
set -x ANDROID_HOME /usr/local/opt/android-sdk

# os specific settings
if [ (uname) = 'Linux' ]
  set TERM screen-256color-bce
end

# using Base16-Shell thus we need to do this in order to
# to have a working color scheme for more information see:
# https://github.com/chriskempson/base16-shell
eval sh $HOME/.config/base16-shell/base16-ocean.dark.sh

# colorize grep
alias grep "grep -n --color"

# using cway too much
alias c "clear"
alias g "git"
alias v "nvim"
alias v. "nvim ."
alias v, "nvim ."
alias n "nvim"
alias n. "nvim ."
alias n, "nvim ."
alias sl "ls" # :-/

# helper alias for SyncMe
alias fhs "pushd .; cd ~/Dropbox/FHNW/SyncMe/SyncMe/; make -i | less; popd; clear"

# run fish in vim mode
fish_vi_mode

source ~/.config/fish/fishmarks.fish
