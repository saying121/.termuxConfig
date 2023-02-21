#!/bin/bash

if [[ ! -d ~/.config ]]; then
	mkdir ~/.config
fi

# pip
ln -sf ~/.termuxConfig/.pip ~/
# nvim
ln -sf ~/.termuxConfig/nvim ~/.config
[[ -d ~/.vim ]] || mkdir ~/.vim
ln -sf ~/.termuxConfig/nvim/tasks.ini ~/.vim/tasks.ini
# vim
ln -sf ~/.termuxConfig/nvim/viml/init.vim ~/.vimrc
# zshrc
ln -sf ~/.termuxConfig/shells/.zshrc ~/.zshrc
# bashrc
ln -sf ~/.termuxConfig/shells/bashrc ~/.bashrc
if [[ ! -d ~/.local/shells ]]; then
	mkdir ~/.local/shells
fi
# tldr
ln -sf ~/.termuxConfig/configs/tldrrc ~/.tldrrc
# npm
ln -sf ~/.termuxConfig/configs/npmrc ~/.npmrc

# 语言
ln -sf ~/.termuxConfig/xprofile ~/.xprofile
