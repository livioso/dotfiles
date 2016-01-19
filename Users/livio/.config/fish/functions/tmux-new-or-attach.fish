function tmux-new-or-attach
	bash -c "tmux attach-session -t $argv || tmux new-session -s $argv"
end
