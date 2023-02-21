export ALL_PROXY=http://127.0.0.1:7890
export HTTPS_PROXY=http://127.0.0.1:7890
export HTTP_PROXY=http://127.0.0.1:7890
nohup clash -f ~/.config/clash/config.yaml 2>&1 &

sudo pkg ranger fzf python python-pip nodejs-lts shfmt ripgrep fd lldb translate-shell

export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
source ~/.nvm/nvm.sh
nvm install v18.13.0
nvm install v16.19.0
nvm alias default v18.13.0

# nvim 安装插件
if [[ ! -d ~/.local/share/nvim/lazy/lazy.nvim ]]; then
	git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable ~/.local/share/nvim/lazy/lazy.nvim
fi
if [[ ! -d ~/.local/share/vim/dein/repos/github.com/Shougo/dein.vim ]]; then
	git clone https://github.com/Shougo/dein.vim ~/.local/share/vim/dein/repos/github.com/Shougo/dein.vim
fi

vim -i NONE -c "call dein#install()" -c "qa"
nvim "+Lazy! sync" +qa

# 给lldb配置runInTerminal
echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
