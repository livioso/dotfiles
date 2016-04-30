# path settings
set PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin /opt/X11/bin /Library/TeX/texbin /usr/local/share/git-core/contrib/diff-highlight/

# environment variables
set -x ANDROID_HOME /usr/local/opt/android-sdk
set -x PIP_REQUIRE_VIRTUALENV true

# os specific settings
if [ (uname) = 'Linux' ]
  set TERM screen-256color-bce
end

# using Base16-Shell thus we need to do this in order to
# to have a working color scheme for more information see:
# https://github.com/chriskempson/base16-shell
eval sh $HOME/.config/base16-shell/base16-ocean.dark.sh
set -Ux fish_term256

# colors used by fish
set -g fish_color_normal      base0
set -g fish_color_command     purple
set -g fish_color_quote       cyan
set -g fish_color_redirection base0
set -g fish_color_end         base0
set -g fish_color_error       red
set -g fish_color_param       blue
set -g fish_color_comment     base01
set -g fish_color_match       cyan
set -g fish_color_search_match "--background=$base02"
set -g fish_color_operator    orange
set -g fish_color_escape      cyan
set -g fish_color_hostname    cyan
set -g fish_color_cwd         yellow
set -g fish_color_git         green

# colorize grep
alias grep "grep -n --color"

# using cway too much
alias c "clear"
alias g "git"
alias v "nvim"
alias v. "nvim ."
alias v, "nvim ."
alias n. "nvim ."
alias n, "nvim ."
alias n "nvim"
alias sl "ls" # :-/
alias gp "git push"
alias gst "git status"
alias claer "clear"
alias jfw "j fw; nvim ."
alias jba "j ba; nvim ."
alias before "history | fzf-tmux"

# helper alias for SyncMe
alias fhs "pushd .; cd ~/Dropbox/FHNW/SyncMe/SyncMe/; make -i | less; popd; clear"

# no greeting
set fish_greeting ""

# run fish in vim mode
fish_vi_mode

# corrects your previous console command
eval (thefuck --alias | tr '\n' ';')

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
  echo -n '$ '

  set_color normal
end


source ~/.config/fish/fishmarks.fish
set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish
