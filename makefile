install: \
	prepare_dirs \
	install_brew \
	install_pips \
	install_gems \
	install_vim \
	install_base16shell \
	macos_set_defaults \
	link \

link:
	ln -f nvim/init.vim ~/.config/nvim/init.vim
	ln -f jetbrains/ideavimrc ~/.ideavimrc
	ln -f nvim/.coc-settings.json ~/.config/nvim/coc-settings.json
	ln -f fish/config.fish ~/.config/fish/config.fish
	ln -f tmux/.tmux.conf ~/.tmux.conf
	ln -f git/.gitconfig ~/.gitconfig
	ln -f macos/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict
	ln -f karabiner/karabiner.json ~/.config/karabiner/karabiner.json
	ln -f .theme ~/.theme

prepare_dirs:
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/fish/completions
	mkdir -p ~/.ipython/profile_default
	mkdir -p ~/Library/KeyBindings
	mkdir -p ~/.config/karabiner/

install_brew:
	brew tap Homebrew/bundle
	brew bundle

install_gems:
	sudo gem install bundler -n/usr/local/bin
	bundle install --system

install_pips:
	pip3 install -r Pipfile

install_vim:
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugInstall +qall
	nvim +UpdateRemotePlugins +qall

install_vim_min:
	wget https://raw.githubusercontent.com/livioso/vim-sensible/master/plugin/sensible.vim
	mv sensible.vim ~/.vimrc

install_base16shell:
	git -C ~/.config/base16-shell pull || \
		git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

macos_set_defaults:
	sh macos/set-defaults.sh
