set GOPATH $HOME/go
function fish_prompt
    eval $GOPATH/bin/powerline-go -error $status -cwd-max-depth 2 -cwd-max-dir-size 7 -modules-right time -shell bare
end

function fish_greeting
	echo "Welcome brave fisherman!"
end

set fish_greeting
alias exit="exit"
alias quit="exit"
alias q=exit
alias c="clear"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias vim="nvim"


bind \cq 'exit'
function sudobangbang --on-event fish_postexec
    abbr !! sudo $argv[1]
end
