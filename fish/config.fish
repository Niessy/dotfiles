for F in $HOME/.config/fish/env/*
	source $F
end

set fish_greeting ""

#
# General stuff
#

# Linux stuff is mostly for minimal cloud GPU/TPU instance

switch (uname)
case Linux
	set -x PATH $HOME/julia/bin $PATH
case Darwin
	set -x PATH /usr/local/anaconda3/bin $PATH
	set -x PATH /usr/local/opt/openssl/bin $PATH
	set -x PATH $HOME/.pulumi/bin $PATH
	set -x GOPATH (go env GOPATH)
	set -x PATH $PATH $GOPATH/bin
	set -x PATH $HOME/julia/usr/bin $PATH

	alias bubu 'brew cleanup; brew prune; brew cask cleanup'
case '*'
	echo 'OS not detected!'
end

set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'

alias gst 'git status'
alias ga 'git add'
alias gc 'git commit'
alias ll 'ls -larth'
alias md 'mkdir -p'

alias j julia
alias c clear
alias v nvim
alias vi nvim
alias vim nvim

alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

set -x EDITOR nvim

switch (uname)
case Linux
case Darwin
	# set -x JAVA_HOME /usr/libexec/java_home
case '*'
	echo 'OS not detected!'
end
