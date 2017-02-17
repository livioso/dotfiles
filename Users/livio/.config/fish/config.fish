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
end

function fish-set-fzf-environment-variables
  set -U FZF_TMUX 1
  set -U FZF_TMUX_HEIGHT 33%
  # use 16 color for fzf
  set -g -x FZF_DEFAULT_OPTS --color=16
end

function fish-set-arbitrary-settings
  set fish_greeting ""
  set -Ux fish_term256
  set -x EDITOR "nvim"
end

function fish-set-aliases
  alias e "exit"
  alias c "clear"
  alias g "hub"
  alias sl "ls"
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

function n -d "(n)eovim with append . when no args."
  if test (count $argv) -eq 0
    /usr/local/bin/nvim .
  else
    /usr/local/bin/nvim $argv
  end
end

function !! -d "!! as in bash"
  eval $history[1]
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

function bd -d 'Fuzzy find directories in parent directories from pwd → backwards cd'
  set dir (pwd | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' | __fzfcmd)
  if test $dir
    cd $dir
  end
end

function fd -d "Fuzzy find directories in sub directories from pwd."
  set dir (find . -type d ! -path '**/\.*' ! -path '**/node_modules*' | __fzfcmd)
  if test $dir
    cd $dir
  end
end

function j -d "Like fish marks but self made with fzf support."
  if test (count $argv) -ne 1
    set dir (cat ~/.fishmarks | __fzfcmd | awk '{print $2}')
    if test $dir
      cd $dir
    end
  else
    set search {$argv[1]}
    while read name dir
      if test $name = $search
        builtin cd $dir
      end
    end < ~/.fishmarks
  end
end

# completion for j
complete -c j -c p --description Mark --no-files -a "
    (cat ~/.fishmarks | cut -f 1 -d ' ')
"

function osx-msgme -d "Send a notification to OSX."
  set notification ($argv[1])
  set title (argv[2])
  osascript -e "display notification $notification with title $title"
end

function osx-battery-percentage -d "Get battery percentage."
  pmset -g batt | sed '1 d' | awk '{print $3}' | sed 's/;*$//'
end

function osx-set-https-proxies-to-mitmproxy -d "See docker_mitmproxy"
  networksetup -setwebproxy Wi-Fi 127.0.0.1 6666
  networksetup -setsecurewebproxy Wi-Fi 127.0.0.1 6666
end

function osx-turn-https-proxies-on -d "Network → Advanced → Proxies: HTTP & HTTPS Proxies"
  networksetup -setwebproxystate Wi-Fi on
  networksetup -setsecurewebproxystate Wi-Fi on
end

function osx-turn-https-proxies-off -d "Network → Advanced → Proxies: HTTP & HTTPS Proxies"
  networksetup -setwebproxystate Wi-Fi off
  networksetup -setsecurewebproxystate Wi-Fi off
end

function git-fzf-commits
  set commit (git log --pretty=format:(git-pretty-format-2) | __fzfcmd | awk '{print $1}')
  if test $commit
    git clear
    git show $commit
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

function tmux-new-or-attach -d "Tmux attach if exising otherwise create."
  bash -c "tmux attach-session -t $argv || tmux new-session -s $argv"
end

function git-pretty-format-1
  echo "%Cred%h%Creset • %Cgreen%cr%Creset %Cblue%an %n ➟ %s"
end

function git-pretty-format-2
  echo "%h • %cr %an ➟ %s"
end

function git-alias -d "Show all the git alias."
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
  # switch-base16-theme eighties
  switch-base16-theme oceanicnext
end

function light -d "Use the light color scheme."
  switch-base16-theme harmonic16-light
end

function docker-stop-all-container -d "Stop all running container."
  docker kill (docker ps -q)
end

# connect mysql --host=127.0.0.1  --user=root --password=root
function docker_mysql_dirtyfeets -d "Run the MySQL Server dirtyfeets docker."
  docker run \
    -e MYSQL_ROOT_PASSWORD=root \
    -e MYSQL_DATABASE="dirtyfeets" \
    -p 3306:3306 \
    -it \
    mysql:5.7
end

function docker_mysql -d "Run the MySQL Server dirtyfeets docker."
  docker run \
    -e MYSQL_ROOT_PASSWORD=root \
    -p 3306:3306 \
    -it \
    mysql
end

# for setup see: http://docs.mitmproxy.org/en/stable/transparent/osx.html
function docker_mitmproxy -d "Run the mitmproxy docker on localhost:6666."
  docker run --rm \
    -v ~/.mitmproxy:/home/mitmproxy/.mitmproxy \
    -v ~/Downloads:/home/Downloads \
    -p 6666:8080 \
    -it mitmproxy/mitmproxy
end

function fish_mode_prompt -d "Displays the current mode."
  echo -n ''
  switch $fish_bind_mode
    case default
      set_color --bold --background black red
      echo '●'
    case insert
      set_color --bold --background black brgrey
      echo '❯'
    case replace-one
      set_color --bold --background black magenta
      echo '●'
    case visual
      set_color --bold --background black green
      echo '●'
  end
  set_color normal
  echo -n ' '
end

function fish_prompt -d "Write out the prompt"
  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  set_color green
  printf (basename (pwd))
  set_color brgrey
  printf ' on '

  set_color blue
  printf (git rev-parse --abbrev-ref HEAD)

  printf "\n"
  set_color brgrey
  printf '❯ '

  set_color normal
end

function fish_right_prompt -d "Right prompt"
  # set_color blue
  # printf '%s' (__fish_git_prompt)
end

function fish_user_key_bindings
  # do this first!
  fish_vi_key_bindings

  # rebind fzf keys to appropriate functions.
  source $HOME/.config/fish/functions/__fzf_ctrl_r.fish
  bind \cr -M insert '__fzf_ctrl_r'
end

### Work Related
function fw-python-env
  builtin cd ~/Fashwell/karl-server/src/python
  . ../env/bin/activate.fish
  set -x PYTHONPATH .
end

function fw-start-server
  set configuration (printf "%s\n" ProductionLocal Production Development | __fzfcmd -d 10)

  if test $configuration
    echo (set_color red)
    echo " → Run Server in «$configuration»"
    echo (set_color normal)
    builtin cd ~/Fashwell/karl-server/src/python
    . ../env/bin/activate.fish
    set -x PYTHONPATH .
    python -m frontend.manage runserver 0.0.0.0:8000 --configuration $configuration
  end
end

function fw-django-shell
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
  fish-set-environment-variables
  fish-set-fzf-environment-variables
  fish-set-arbitrary-settings
  load-base16-theme
end

main
