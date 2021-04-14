# NOTE: Set WSL_FLAG in .zprofile
source ~/.config/zsh-plugins/antigen.zsh
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH
if [ $WSL_FLAG != false ]; then
    export PATH=/mnt/c/Users/iplay/AppData/Local/Programs/Microsoft\ VS\ Code/bin:/mnt/c/Windows/System32/:$PATH
fi
export GPG_TTY=$(tty)

antigen use oh-my-zsh
antigen bundle git

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle agkozak/zsh-z
antigen apply

export EDITOR='nvim'
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias coz'$EDITOR ~/.zshrc'
alias slack-term-em='slack-term --config ~/.config/slack-term/embedded-slack-token'
# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
eval "$(starship init zsh)"
# sh ~/.motd.sh
