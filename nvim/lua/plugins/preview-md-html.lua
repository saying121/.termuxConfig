return {
    {
        'iamcco/markdown-preview.nvim',
        lazy = true,
        -- 需要调整nodejs版本
        build = 'source /usr/share/nvm/init-nvm.sh; nvm use v18; cd app && npm install',
        ft = { 'markdown' },
    },
    {
        'turbio/bracey.vim',
        lazy = true,
        -- 需要调整nodejs版本
        build = 'source /usr/share/nvm/init-nvm.sh; nvm use v16; npm install --prefix server',
        ft = { 'html' },
    },
}
