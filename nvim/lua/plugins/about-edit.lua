return {
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode = { 'n', 'v' } },
            { 'gb', mode = { 'n', 'v' } },
        },
        config = function()
            require 'Comment'.setup()
        end
    },
    {
        'tpope/vim-surround',
        keys = {
            { 'ys', mode = 'n' },
            { 'yS', mode = 'n' },
            { 'ds', mode = 'n' },
            { 'cs', mode = 'n' },
            { 'S', mode = 'v' },
        },
    },
}
