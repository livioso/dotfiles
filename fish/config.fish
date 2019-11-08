# order is important: /usr/local/ before e.g. /usr/bin otherwise
# we still use the pre-installed versions instead of brew's
function fish-set-path -d "PATH settings"
  set PATH \
    /usr/local/opt/libressl/bin \
    /usr/local/bin \
    /usr/local/sbin \
    /bin \
    /sbin \
    /usr/bin \
    /usr/sbin \
    /usr/local/share/git-core/contrib/diff-highlight \
    /usr/local/opt/asdf/shims/
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

function fish-source-private -d "Source extra (privat, work)"
  test -e {$HOME}/.config/fish/private.fish && \
    source {$HOME}/.config/fish/private.fish
end

function fish_mode_prompt -d "Displays the current mode."
  echo -n ''
  switch $fish_bind_mode
    case default
      set_color --bold --background black red
      echo '●'
    case insert
      set_color --bold --background black brgrey
      echo 'ـ'
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

  if git-is-repo
    set_color brgrey
    printf ' on '

    set_color blue
    printf (git rev-parse --abbrev-ref HEAD)
  end

  printf "\n"
  set_color brgrey
  printf '❯ '

  set_color normal
end

function fish-set-fzf-environment-variables
  set -U FZF_TMUX 1
  set -U FZF_TMUX_HEIGHT 33%
  set -g -x FZF_DEFAULT_OPTS --color=16 # use 16 color for fzf
end

function fish-set-environment-variables -d "ENV variables"
  set -x PIP_REQUIRE_VIRTUALENV true
end

function fish-set-arbitrary-settings
  # allow to use emacs style key bindings together with vi
  # style key bindings, default behaviour before fish 2.4
  # https://github.com/fish-shell/fish-shell/issues/3556
  set -g -x fish_key_bindings "fish_hybrid_key_bindings"
  set fish_greeting ""
  set -Ux fish_term256
  set -g -x EDITOR "nvim"

  export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
  export PIPENV_SHELL_COMPAT=1

  # see https://github.com/pyca/cryptography/issues/2692
  export LDFLAGS="-L/usr/local/opt/openssl/lib"
  export CPPFLAGS="-I/usr/local/opt/openssl/include"
  export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
  export PYTHONDONTWRITEBYTECODE=1

  # asdf
  source /usr/local/opt/asdf/asdf.fish
end

function fish-set-aliases
  alias e "exit"
  alias c "clear"
  alias cl "clear"
  alias cel "clear"
  alias cle "clear"
  alias clea "clear"
  alias cler "clear"
  alias clae "clear"
  alias claer "clear"
  alias clare "clear"
  alias caler "clear"
  alias clera "clear"
  alias grep "grep -n --color"
  alias ll "exa --long"
  alias ls "exa"
  alias cat "bat"

  # read and merge history from disk
  alias hr 'history --merge'
end

function fish-set-abbreviations
  abbr --add sar "ag -l | xargs sed -i '' -e 's/foo/bar/g'"
end

function source-fish -d "Source fish config."
  source ~/.config/fish/config.fish
end

function n -d "(n)eovim with append . when no args."
  if test (count $argv) -eq 0
    /usr/local/bin/nvim .
  else
    /usr/local/bin/nvim $argv
  end
end

function cd -d "Auto ls for each cd."
  if [ -n $argv[1] ]
    builtin cd $argv[1]
    and exa
  else
    builtin cd ~
    and exa
  end
end

function osx-battery-percentage -d "Get battery percentage."
   pmset -g batt | sed '1 d' | awk '{print $3}' | sed 's/;*$//'
end

function j -d "Like fish marks but self made with fzf support."
  if test (count $argv) -ne 1
    set dir (cat ~/.fishmarks | fzf-tmux | awk '{print $2}')
    if test $dir
      builtin cd (eval echo "$dir")
    end
  else
    set search {$argv[1]}
    while read name dir
      if test $name = $search
        builtin cd (eval echo "$dir")
      end
    end < ~/.fishmarks
  end
end

# completion for j
complete -c j -c p --description Mark --no-files -a "
    (cat ~/.fishmarks | cut -f 1 -d ' ')
"

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

function git-is-repo -d "Test if the current directory is a repository"
  if not command git rev-parse --git-dir > /dev/null ^ /dev/null
    return 1
  end
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

function light -d "Use the light color scheme."
  switch-base16-theme harmonic-light
end

function dark -d "Use the favorite oceanicnext dark color scheme."
  if test (count $argv) -ne 1
    switch-base16-theme oceanicnext
  else
    switch-base16-theme $argv
  end
end

# completion for dark
complete -c dark -c p --description Mark --no-files -a "
    irblack eighties tomorrow-night-eighties oceanicnext greenscreen
"

function docker-stop-all-container -d "Stop all running container."
  docker kill (docker ps -q)
end

function main
  fish-set-path
  fish-set-aliases
  fish-set-abbreviations
  fish-set-colors
  fish-set-environment-variables
  fish-set-fzf-environment-variables
  fish-set-arbitrary-settings
  fish-source-private
  load-base16-theme
end

main
