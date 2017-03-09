install: perpare_dirs install_minimum install_bundle link cleanup

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
	ln -f macos/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict

prepare_dirs:
	mkdir -p ~/Library/KeyBindings/
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/fish
	mkdir -p ~/.tmuxinator

install_bundle:
	# brew
	brew tap Homebrew/bundle
	brew bundle

	# gems
	gem install bundler
	bundle install --system

install_minimum:
	# make vim sensible
	wget https://raw.githubusercontent.com/livioso/vim-sensible/master/plugin/sensible.vim > ~/.vimrc

cleanup:
	brew cleanup
	brew cask cleanup
