missing_args=()
# Install Starship Prompt
if [ ! -f /usr/local/bin/starship ]; then
	sh -c "$(curl -fsSL https://starship.rs/install.sh)"
fi

# Check if apt is installed
if (( $+commands[apt] )); then
	# Install Zoxide
	if ! (( $+commands[zoxide] )); then
		missing_args+=('zoxide')
		echo 'eval "$(zoxide init zsh)"' >> $XDG_HOME/.zshrc
	fi
	# Install FZF
	if ! (( $+commands[fzf] )); then
		missing_args+=('fzf')
	fi
	# Run install command
	if [ ${#missing_args[@]} -ne 0 ]; then
		sudo apt update
		sudo apt install $missing_args
	fi
fi
