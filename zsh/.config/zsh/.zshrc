# If you come from bash you might have to change your $PATH.
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
export PATH=$HOME/.yarn/bin/:$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.luarocks/bin:$HOME/aibin:$HOME/.cargo/bin:/usr/local/go/bin/:$HOME/go/bin/:$PATH
export PATH="$SPICETIFY_INSTALL:$PATH"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
# Colors
autoload -Uz colors && colors
# Check for WSL in kernel info
if [[ $(uname -r) == *"WSL"* ]]; then
    export PATH=/mnt/c/Windows/SysWOW64/clip.exe:$PATH
fi
fpath+=${ZDOTDIR:-~}/completions
fpath+=${ZDOTDIR:-~}/plugins
source "$ZDOTDIR/zsh-functions"
zsh_add_file "zsh-aliases"
# # zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "marlonrichert/zsh-autocomplete"
# Soruce zsh-functions
zmodload zsh/zprof
export GPG_TTY=$(tty)
# Opting not to source the bootstrap file and will run this manually
# source ~/.config/zsh-plugins/bootstrap.zsh

export EDITOR='nvim'
export SUDO_EDITOR='nvim'
alias python='python3'

# if [[ ! $(uname -r) == *"WSL"* ]]; then
#     alias ssh='kitty +kitten ssh'
# fi
# Completions
# autoload -U compinit
# compinit -i
skip_global_compinit=1


# Keybindings
bindkey -s '^f' 'fzf^M'
# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Add prompt and zoxide
eval "$(zoxide init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
eval "$(starship init zsh)"
