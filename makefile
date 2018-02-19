install: \
	prepare_dirs \
	install_brew \
	install_gems \
	install_pips \
	install_npm \
	install_vim \
	install_vim_min \
	install_fish \
	install_base16shell \
	install_glcoud \
	macos_set_defaults \
	link \
	cleanup

link:
	ln -f .nvimrc ~/.config/nvim/init.vim
	ln -f .fishrc ~/.config/fish/config.fish
	ln -f .tmux.conf ~/.tmux.conf
	ln -f .tmuxinator/* ~/.tmuxinator/
	ln -f .gitmessage ~/.gitmessage
	ln -f .gitconfig ~/.gitconfig
	ln -f .emacs ~/.emacs
	ln -f .npmrc ~/.npmrc
	ln -f .flake8 ~/.config/flake8
	ln -f .ipython ~/.ipython/profile_default/ipython_config.py
	ln -f .pdbrc ~/.pdbrc
	ln -f .ctags ~/.ctags
	ln -f .theme ~/.theme
	ln -f macos/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict
	ln -f karabiner/karabiner.json ~/.config/karabiner/karabiner.json
	ln -f hammerspoon/*.lua ~/.hammerspoon/

prepare_dirs:
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/fish
	mkdir -p ~/.tmuxinator
	mkdir -p ~/.config/fish/completions
	mkdir -p ~/.ipython/profile_default
	mkdir -p ~/.ipython/profile_fashwell
	mkdir -p ~/Library/KeyBindings
	mkdir -p ~/.config/karabiner/
	mkdir -p ~/.hammerspoon/

install_brew:
	brew tap Homebrew/bundle
	brew bundle

install_gems:
	sudo gem install bundler -n/usr/local/bin
	bundle install --system

install_pips:
	pip install -r Pipfile

install_npm:
	npm install -g create-react-app
	npm install -g create-react-native-app
	npm install -g @google-cloud/functions-emulator
	npm install -g lighthouse
	npm install -g yo

install_glcoud:
	gcloud components install kubectl

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
	wget https://raw.githubusercontent.com/livioso/vim-sensible/master/plugin/sensible.vim
	mv sensible.vim ~/.vimrc

install_fish:
	# get fisher
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
	fish -c "fisher barnybug/docker-fish-completion Doctusoft/google-cloud-sdk-fish-completion"
	# link fish autocompletion ln -f ~/.bin/tmuxinator.fish ~/.config/fish/completions/

install_base16shell:
	git -C ~/.config/base16-shell pull || \
		git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

update_base16shell:
	cd ~/.config/base16-shell && git pull

macos_set_defaults:
	sh macos/set-defaults.sh

cleanup:
	brew cleanup
	brew cask cleanup

doctor:
	brew doctor
	tmuxinator doctor
