install: perpare_dirs install_minimum install_brew install_gems install_pip macos_set_defaults link cleanup

link:
	ln -f .nvimrc ~/.config/nvim/init.vim
	ln -f .fishrc ~/.config/fish/config.fish
	ln -f .tmux.conf ~/.tmux.conf
	ln -f .tmuxinator/* ~/.tmuxinator/
	ln -f .gitmessage ~/.gitmessage
	ln -f .gitconfig ~/.gitconfig
	ln -f .emacs ~/.emacs
	ln -f .npmrc ~/.npmrc
	ln -f .marks ~/.fishmarks
	ln -f .flake8 ~/.config/flake8
	ln -f .ipython ~/.ipython/profile_default/ipython_config.py
	ln -f .pdbrc ~/.pdbrc
	ln -f .ctags ~/.ctags
	ln -f .theme ~/.theme
	ln -f macos/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict

prepare_dirs:
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/fish
	mkdir -p ~/.tmuxinator
	mkdir -p ~/.config/fish/completions
	mkdir -p ~/.ipython/profile_default/ipython_config.py
	mkdir -p ~/Library/KeyBindings/

install_brew:
	brew tap Homebrew/bundle
	brew bundle

install_gems:
	gem install bundler
	bundle install --system

	# link fish autocompletion
	ln -f ~/.bin/tmuxinator.fish ~/.config/fish/completions/

install_pips:
	pip install -r Pipfile

install_vim:
	# get vimplug
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	# install all plugins
	nvim +PlugInstall +qall
	
	# update remote plugins
	nvim +UpdateRemotePlugins +qall

install_vim_min:
	# make vim sensible
	wget https://raw.githubusercontent.com/livioso/vim-sensible/master/plugin/sensible.vim > ~/.vimrc

install_fish:
	# get fisher
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
	fish -c "fisher fzf barnybug/docker-fish-completion Doctusoft/google-cloud-sdk-fish-completion"

macos_set_defaults:
	sh macos/set-defaults.sh

install_base16shell:
	git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

cleanup:
	brew cleanup
	brew cask cleanup