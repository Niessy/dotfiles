#!/usr/bin/env bash

# remove old files
rm -rf $HOME/.config/nvim/
rm -rf $HOME/.config/starship.toml
rm ~/.tmux.conf
rm ~/.gitconfig
rm ~/.bashrc
rm ~/.zshrc
rm ~/.config/kitty/kitty.conf
rm ~/.config/alacritty/alacritty.yml
rm ~/.julia/config/startup.jl
rm ~/.julia/config/startup_ijulia.jl

# symlinks

mkdir -p ~/.config/alacritty
mkdir -p ~/.config/nvim/{lua,vim}
mkdir -p ~/.julia/config
mkdir -p ~/.config/kitty

if [ "$(uname -s)" == "Darwin" ]
then
	echo "On MacOS ..."
	ln -s $PWD/bashrc ~/.bashrc
	ln -s $PWD/zshrc ~/.zshrc
	ln -s $PWD/alacritty.yml ~/.config/alacritty/alacritty.yml
else
	echo "On Linux ...?"
	ln -s $PWD/bashrc_linux ~/.bashrc
	ln -s $PWD/zshrc_linux ~/.zshrc
	ln -s $PWD/alacritty_linux.yml ~/.config/alacritty/alacritty.yml
fi
ln -s $PWD/init.vim ~/.config/nvim/init.vim
ln -s $PWD/coc-settings.json ~/.config/nvim/coc-settings.json
ln -s $PWD/tmux.conf ~/.tmux.conf
ln -s $PWD/gitconfig ~/.gitconfig
ln -s $PWD/startup.jl ~/.julia/config/startup.jl
ln -s $PWD/startup_ijulia.jl ~/.julia/config/startup_ijulia.jl
ln -s $PWD/lua/*.lua ~/.config/nvim/lua/
ln -s $PWD/vim/* ~/.config/nvim/vim/
ln -s $PWD/starship.toml ~/.config/starship.toml
ln -s $PWD/kitty.conf ~/.config/kitty/kitty.conf
