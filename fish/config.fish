set GOPATH $HOME/go
function fish_prompt
    eval $GOPATH/bin/powerline-go -error $status -cwd-max-depth 2 -cwd-max-dir-size 7 -modules-right time -shell bare
end

function fish_greeting
	echo "Welcome fellow fisherman!"
end

set fish_greeting

set exit exit -0
