return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    keys = {
        { ':', mode = { 'n', 'v', 't' } },
        { '/', mode = { 'n', 'v', 't' } },
        { '?', mode = { 'n', 'v', 't' } },
    },
    dependencies = {
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'f3fora/cmp-spell',
        {
            'L3MON4D3/LuaSnip',
            dependencies = {
                'saadparwaiz1/cmp_luasnip',
                'rafamadriz/friendly-snippets',
            },
        },
    },
    config = function()
        local kind_icons = {
            Text = "",
            Method = "m",
            Function = "",
            Constructor = "",
            Field = "",
            Variable = "",
            Class = "",
            Interface = "",
            Module = "",
            Property = "",
            Unit = "",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = "",
        }

        require("luasnip.loaders.from_vscode").lazy_load()

        local cmp = require 'cmp'
        local compare = require 'cmp.config.compare'

        cmp.setup({
            -- matching = {
            --     disallow_fuzzy_matching = true,
            --     disallow_partial_fuzzy_matching = true,
            --     disallow_partial_matching = true,
            --     disallow_prefix_unmatching = true,
            -- },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
                    vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            buffer = "[Buf]",
                            path = "[Path]",
                            luasnip = "[LuaSnip]",
                            spell = "[spell]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[Latex]",
                        })[entry.source.name]
                    return vim_item
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<C-b>'] = cmp.mapping.scroll_docs( -1),
                ['<C-f>'] = cmp.mapping.scroll_docs(1),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

            }),
            sources = cmp.config.sources({
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'path' },
                { name = 'buffer' },
            }, {
                { name = 'spell' },
                { name = 'nerdfonts' },
                { name = 'rime' }
            }),
            experimental = {
                ghost_text = true
            },
            sorting = {
            },
        })
        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
            }, {
                { name = 'buffer' },
            })
        })
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })
        vim.opt.spell = true
        vim.opt.spelllang = { 'en_us' }
    end
}
