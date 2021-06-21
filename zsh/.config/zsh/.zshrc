# NOTE: Set WSL_FLAG in .zprofile
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.luarocks/bin:$PATH
# Check for WSL in kernel info
if [[ $(uname -r) == *"WSL"* ]]; then
        export PATH=/mnt/c/Users/iplay/AppData/Local/Programs/Microsoft\ VS\ Code/bin:/mnt/c/Windows/System32/:$PATH
fi
if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ]; then
  [ -z "${TMUX}" ] && { tmux attach || tmux; } >/dev/null 2>&1
fi
# Soruce zsh-functions
source "$ZDOTDIR/zsh-functions"
zsh_add_file "zsh-aliases"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

export GPG_TTY=$(tty)
# Opting not to source the bootstrap file and will run this manually
# source ~/.config/zsh-plugins/bootstrap.zsh

export EDITOR='nvim'

# Completions
autoload -U compinit
compinit -i


# Keybindings
bindkey -s '^f' 'fzf^M'
# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Add prompt and zoxide
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"