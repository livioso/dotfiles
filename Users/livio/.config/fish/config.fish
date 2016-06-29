# path settings
set PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin /opt/X11/bin /Library/TeX/texbin /usr/local/share/git-core/contrib/diff-highlight/

# environment variables
set -x ANDROID_HOME /usr/local/opt/android-sdk
set -x PIP_REQUIRE_VIRTUALENV true
set -x REACT_EDITOR subl

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
set -U FZF_TMUX 1

# os specific settings
if [ (uname) = 'Linux' ]
  set TERM screen-256color-bce
end

# using Base16-Shell thus we need to do this in order to
# to have a working color scheme for more information see:
# https://github.com/chriskempson/base16-shell
eval sh $HOME/.config/base16-shell/base16-eighties.dark.sh
set -Ux fish_term256

# no greeting
set fish_greeting ""

# load fish marks
source $HOME/.config/fish/fishmarks.fish

function fish_mode_prompt --description "Displays the current mode"
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

function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

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

function fish_user_key_bindings
  # do this first!
  fish_vi_key_bindings

  # rebind fzf keys to appropriate functions.
  source $HOME/.config/fish/functions/__fzf_ctrl_r.fish
  bind \cr -M insert '__fzf_ctrl_r'
end

# aliases
alias git "hub"
alias c "clear"
alias g "git"
alias sl "ls"
alias n "nvim"
alias n. "nvim ."
alias n, "nvim ."
alias claer "clear"
alias grep "grep -n --color"
alias subl "open -a /Applications/Sublime\ Text\ 3.app/"

# fish marks
alias jfw "j fw; nvim ."
alias jba "j ba; nvim ."
alias jre "j re; nvim ."
