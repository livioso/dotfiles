install: \
	prepare_dirs \
	install_brew \
	install_pips \
	install_gems \
	install_vim \
	install_base16shell \
	macos_set_defaults \
	link \
	cleanup

link:
	ln -f nvim/init.vim ~/.config/nvim/init.vim
	ln -f jetbrains/ideavimrc ~/.ideavimrc
	ln -f nvim/.coc-settings.json ~/.config/nvim/coc-settings.json
	ln -f fish/config.fish ~/.config/fish/config.fish
	ln -f tmux/.tmux.conf ~/.tmux.conf
	ln -f git/.gitmessage ~/.gitmessage
	ln -f git/.gitconfig ~/.gitconfig
	ln -f python/.ipython ~/.ipython/profile_default/ipython_config.py
	ln -f python/.pdbrc ~/.pdbrc
	ln -f macos/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict
	ln -f karabiner/karabiner.json ~/.config/karabiner/karabiner.json
	ln -f hammerspoon/*.lua ~/.hammerspoon/
	ln -f .theme ~/.theme

prepare_dirs:
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/fish/completions
	mkdir -p ~/.ipython/profile_default
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

install_vim:
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugInstall +qall
	nvim +UpdateRemotePlugins +qall

install_vim_min:
	wget https://raw.githubusercontent.com/livioso/vim-sensible/master/plugin/sensible.vim
	mv sensible.vim ~/.vimrc

setup_asdf:
	asdf plugin-add python https://github.com/tuvistavie/asdf-python.git
	asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
	asdf install python 3.6.5
	asdf install python 2.7
	asdf global python 3.5.6

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
