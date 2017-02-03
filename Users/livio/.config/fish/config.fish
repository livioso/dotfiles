#################
### Functions ###
#################

function fish-set-path -d "PATH settings"
  set PATH \
    /bin \
    /sbin \
    /usr/bin \
    /usr/sbin \
    /opt/X11/bin \
    /usr/local/bin \
    /Library/TeX/texbin \
    /Users/livio/.yarn/bin \
    /usr/local/share/git-core/contrib/diff-highlight/ \
    /opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/
end

function fish-set-environment-variables -d "ENV variables"
  set -x ANDROID_HOME /usr/local/opt/android-sdk
  set -x PIP_REQUIRE_VIRTUALENV true
  set -x REACT_EDITOR subl
  set -x GOOGLE_APPLICATION_CREDENTIALS /Users/livio/.credentials-gcloud.json
end

function fish-set-colors -d "Set colors used by Fish"
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
end

function fish-colorful-man-pages -d "See http://blog.0x1fff.com/2009/11/linux-tip-color-enabled-pager-less.html"
  setenv -x LESS_TERMCAP_mb (set_color -o red)
  setenv -x LESS_TERMCAP_md (set_color -o red)
  setenv -x LESS_TERMCAP_me (set_color normal)
  setenv -x LESS_TERMCAP_se (set_color normal)
  setenv -x LESS_TERMCAP_so (set_color -b blue -o yellow)
  setenv -x LESS_TERMCAP_ue (set_color normal)
  setenv -x LESS_TERMCAP_us (set_color -o green)
end

function fish-set-arbitrary-settings
  set fish_greeting ""
  set -Ux fish_term256
  set -x EDITOR "nvim"

  # less with colors
  set -x LESS "-RSM~gIsw"

  # use 16 color for fzf
  set -g -x FZF_DEFAULT_OPTS --color=16

  # load fish marks
  source $HOME/.config/fish/fishmarks.fish
end

function fish-set-aliases
  alias e "exit"
  alias c "clear"
  alias g "hub"
  alias sl "ls"
  alias n "/usr/local/bin/nvim"
  alias claer "clear"
  alias clare "clear"
  alias clera "clear"
  alias grep "grep -n --color"
  alias subl "open -a /Applications/Sublime\ Text\ 3.app/"
  alias t "tree -L 1 -a ."
  alias ci "g ci"
  alias cia "g cia"
  alias st "g st"
  alias pull "g pull"
  alias push "g push"
  alias pd "prevd"
  alias nd "nextd"
  alias jfw "j fw; nvim ."
  alias jfw-app "j fw/app; nvim ."
  alias jfw-server "j fw/server; nvim ."
end

function source-🐟 -d "Source fish config."
  source ~/.config/fish/config.fish
end

function cd -d "Auto ls for each cd."
  if [ -n $argv[1] ]
    builtin cd $argv[1]
    and ls -AF
  else
    builtin cd ~
    and ls -AF
  end
end

function fd -d "Fuzzy find directories in all subdirectories from pwd."
  set dir (find . -type d ! -path '**/\.*' ! -path '**/node_modules*' | fzf-tmux +m +s --color=16)
  if test $dir
    cd $dir
  end
end

function git-rebase-unpushed -d "Git rebase -i the unpushed commits."
  set current_branch (git branch | awk '{print $2}' | sed '/^$/d')
  set last_pushed_hash (git log --format="%h" -n 1 origin/$current_branch)
  set head_hash (git log --format="%h" -n 1 $current_branch)

  if test $current_branch
    if [ $last_pushed_hash != $head_hash ]
      git rebase -i $last_pushed_hash
    else
      set_color --bold --background black blue
      echo '✗ all commits are pushed: nothing to rebase.'
    end
  end
end

function git-pretty-format-1
  echo "%Cred%h%Creset • %Cgreen%cr%Creset %Cblue%an %n ➟ %s"
end

function git-alias
  set_color --bold --background black blue
  echo 'Available Git alias:'
  git config -l | grep 'alias.' | cut -c 10- | sed ' s/=/ → /' | sort
end

function git-lg -d "Git improved log."
  git log \
    --color \
    --abbrev-commit -7 \
    --pretty=format:(git-pretty-format-1)
end

function git-lga -d "Git improved log with graph."
  git log \
    --color \
    --graph \
    --pretty=format:(git-pretty-format-1)
end

function git-standup -d "Git log over the last 24h."
  git log \
    --color \
    --branches="*" \
    --abbrev-commit \
    --author="Livio" \
    --since="24hours" \
    --pretty=format:(git-pretty-format-1)
end

function switch-base16-theme
  echo $argv > ~/.theme
  load-base16-theme
end

function load-base16-theme -d "Load the colors scheme defined in ~/.theme"
  if status --is-interactive
    set theme (cat ~/.theme)
    eval sh $HOME/.config/base16-shell/scripts/base16-$theme.sh
  end
end

function dark -d "Use the dark color scheme."
  switch-base16-theme eighties
end

function light -d "Use the light color scheme."
  switch-base16-theme harmonic16-light
end

function fish_mode_prompt -d "Displays the current mode."
  echo -n ''
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

function fish_prompt -d 'Write out the prompt'
  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  set_color green
  echo -n (prompt_pwd)

  set_color blue
  printf ' ❯ '

  set_color normal
end

function fish_right_prompt -d
  set_color blue
  printf '%s' (__fish_git_prompt)
end

function fish_user_key_bindings
  # do this first!
  fish_vi_key_bindings

  # rebind fzf keys to appropriate functions.
  source $HOME/.config/fish/functions/__fzf_ctrl_r.fish
  bind \cr -M insert '__fzf_ctrl_r'
end

### Work Related
function fwPythonEnv
  builtin cd ~/Fashwell/karl-server/src/python
  . ../env/bin/activate.fish
  set -x PYTHONPATH .
end

function __fw-start-server
  echo (set_color $argv[2])
  echo " → Run Server in «$argv[1]»"
  echo (set_color normal)
  builtin cd ~/Fashwell/karl-server/src/python
  . ../env/bin/activate.fish
  set -x PYTHONPATH .
  python -m frontend.manage runserver 0.0.0.0:8000 --configuration $argv[1]
end

function fwStartServerProductionLocal
  __fw-start-server ProductionLocal green
end

function fwStartServerDevelopment
  __fw-start-server Development purple
end

function fwDjangoShell
  fwPythonEnv
  python -m frontend.manage shell
end

function buildJSCTags
  bash -c "find . -type f -iregex '.*\.js' -not -path './node_modules/*' -exec jsctags {} -f \; | sed '/^\$/d' | sort > tags" &
end

function main
  fish-set-path
  fish-set-aliases
  fish-set-colors
  fish-colorful-man-pages
  fish-set-environment-variables
  fish-set-arbitrary-settings
  load-base16-theme
end

main
