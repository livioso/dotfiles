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

# no greeting
set fish_greeting ""

# load fish marks
source $HOME/.config/fish/fishmarks.fish

function fish_mode_prompt --description "Displays the current mode"
  switch $fish_bind_mode
    case default
      set_color --bold --background black red
      echo '▲'
    case insert
      set_color --bold --background black blue
      echo '●'
    case replace-one
      set_color --bold --background black magenta
      echo '▲'
    case visual
      set_color --bold --background black green
      echo '▲'
  end
  set_color normal
  echo -n ' '
end

function fish_prompt --description 'Write out the prompt'
  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  set_color green
  echo -n (prompt_pwd)

  set_color red
  printf ' > '

  set_color normal
end

function fish_user_key_bindings
  # do this first!
  fish_vi_key_bindings

  # rebind fzf keys to appropriate functions.
  source $HOME/.config/fish/functions/__fzf_ctrl_r.fish
  bind \cr -M insert '__fzf_ctrl_r'
end

function fish_right_prompt -d "Write out the right prompt"
  set_color blue
  printf '%s' (__fish_git_prompt)
end

# cs => cd & ls
function cs
   cd $argv
   ls
end

# aliases
alias e "exit"
alias c "clear"
alias g "hub"
alias sl "ls"
alias n "/usr/local/bin/nvim"
alias claer "clear"
alias grep "grep -n --color"
alias subl "open -a /Applications/Sublime\ Text\ 3.app/"
alias t "tree -L 1 -a ."
alias ci "g ci"
alias cia "g cia"
alias st "g st"

# fish marks
alias jfw "j fw; nvim ."
alias jba "j ba; nvim ."
alias jre "j re; nvim ."
alias jfw-python "j fw-python; nvim ."
alias jba-slides "j ba-slides; nvim ."

# color scheme
function loadBase16Theme
  cat ~/.theme | read theme
  eval sh $HOME/.config/base16-shell/scripts/base16-$theme.sh
end

# use dark color scheme
function dark
  # echo oceanicnext > ~/.theme
  echo eighties > ~/.theme
  loadBase16Theme
end

# use light color scheme
function light
  echo harmonic16-light > ~/.theme
  loadBase16Theme
end

set -Ux fish_term256
loadBase16Theme

# Fashwell
function fwPythonEnv
  j fw-python
  . ../env/bin/activate.fish
  set -x PYTHONPATH /Users/livio/Fashwell/karl/src/python
end

function fwStartServer
  fwPythonEnv
  python -m frontend.manage runserver 0.0.0.0:8000 --configuration 'Development'
end

function fwDjangoShell
    fwPythonEnv
    python -m frontend.manage shell
end


