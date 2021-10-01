missing_args=()
# Install Starship Prompt
if ! (( $+commands[starship] )); then
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
    # Install FZF
    if ! (( $+commands[stow] )); then
        missing_args+=('stow')
    fi
    # Run install command
    if [ ${#missing_args[@]} -ne 0 ]; then
        sudo apt update
        sudo apt install $missing_args
    fi
fi

if ! (( $+commands[luarocks] )); then
    wget https://luarocks.org/releases/luarocks-3.3.1.tar.gz
    tar zxpf luarocks-3.3.1.tar.gz
    ./luarocks-3.3.1/configure
    make luarocks-3.3.1/
    sudo make install luarocks-3.3.1/
fi

if ! (( $+commands[pfetch] )); then
    wget https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch
    mv pfetch /home/ethan/bin/
    chmod +x /home/ethan/bin/pfetch
fi
if ! (( $+commands[beautysh] )); then
    pip install beautysh
fi
if ! (( $+commands[exa] )); then
    cargo install exa
fi
if ! (( $+commands[stylua] )); then
    cargo install stylua
fi
