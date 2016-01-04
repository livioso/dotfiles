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
eval sh $HOME/.config/base16-shell/base16-eighties.dark.sh

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

# no greeting
set fish_greeting ""

# run fish in vim mode
fish_vi_mode

function fish_mode_prompt --description "Displays the current mode"
  # Do nothing if not in vi mode
  if set -q __fish_vi_mode
    switch $fish_bind_mode
      case default
        set_color --bold --background red white
        echo ' N '
      case insert
        set_color --bold --background blue white
        echo ' I '
      case replace-one
        set_color --bold --background green white
        echo ' R '
      case visual
        set_color --bold --background magenta white
        echo ' V '
    end
    set_color normal
    echo -n ' '
  end
end

function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  # PWD
  set_color blue
  echo -n (prompt_pwd)

  set_color green
  printf '%s ' (__fish_git_prompt)

  if not test $last_status -eq 0
    set_color $fish_color_error
  end

  set_color red
  echo -n '>> '

  set_color normal
end


source ~/.config/fish/fishmarks.fish
