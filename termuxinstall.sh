#!/bin/bash

export ALL_PROXY=http://127.0.0.1:7890
export HTTPS_PROXY=http://127.0.0.1:7890
export HTTP_PROXY=http://127.0.0.1:7890
nohup clash -f ~/.config/clash/config.yaml 2>&1 &

# link config
~/.linuxConfig/linkConfig.sh
pkg i nodejs golang rust python python-pip zsh exa neovim rsync w3m openssh \
    neofetch fzf gotop clash
pip install thefuck pynvim

sudo npm i -g npm neovim sql-language-server
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

sudo npm install --save-dev --save-exact prettier

# 安装oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# omz plug
~/.termuxConfig/shells/ohmyzsh.sh

~/.termuxConfig/nvim/install.sh
