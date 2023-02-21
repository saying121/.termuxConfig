#!/bin/bash

# 安装web-search
if [[ ! -d ~/.oh-my-zsh/custom/plugins/web-search ]]; then
	git clone https://github.com/lesonky/web-search.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/web-search
fi

# 安装git-open
sudo npm install --global git-open
if [[ ! -d ~/.oh-my-zsh/custom/plugins/git-open ]]; then
	git clone https://github.com/paulirish/git-open.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-open
fi

# 安装fzf-tab
if [[ ! -d ~/.oh-my-zsh/custom/plugins/fzf-tab ]]; then
	git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
fi
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 移除oh-my-zsh生成的.zshrc,重新链接.zshrc
if [[ -f ~/.zshrc.pre-oh-my-zsh ]]; then
	rm ~/.zshrc.pre-oh-my-zsh
fi
if [[ -f ~/.zshrc ]]; then
	rm ~/.zshrc
fi
ln -s ~/.linuxConfig/shells/.zshrc ~/.zshrc
