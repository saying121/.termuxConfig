return {
    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'CursorMoved ',
        config = function()
            -- vim.cmd [[hi IndentBlanklineIndent1 guibg=#9D7CD8 guifg=#9D7CD8]]
            require("indent_blankline").setup {
                space_char_blankline = " ",
                show_current_context = true,
                -- show_current_context_start = true,
            }
        end
    },
    {
        'folke/tokyonight.nvim',
        -- priority = 1000,
        -- cond = true,
        config = function()
            vim.cmd.colorscheme('tokyonight')
            vim.cmd.colorscheme('plugcolors')
            require("tokyonight").setup({
                style = "night",
                transparent = true,
                terminal_colors = true,
                -- Background styles. Can be "dark", "transparent" or "normal"
                styles = {
                    sidebars = "transparent", -- style for sidebars, see below
                    floats = "transparent", -- style for floating windows
                }
            })
        end
    },
}
