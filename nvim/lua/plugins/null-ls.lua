return {
    'jose-elias-alvarez/null-ls.nvim',
    ft = {
        'angular',
        'css',
        'flow',
        'graphql',
        'html',
        'javascript',
        'json',
        'jsx',
        'less',
        'markdown',
        'python',
        'scss',
        'sh',
        'sql',
        'typescript',
        'vim',
        'vue',
        'yaml',
        'tex',
        'asciidoc',
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local null_ls = require 'null-ls'
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.shfmt,
                null_ls.builtins.formatting.sql_formatter,
                null_ls.builtins.formatting.json_tool,
                null_ls.builtins.formatting.prettier,
                -- null_ls.builtins.formatting.clang_format,
                -- null_ls.builtins.code_actions.shellcheck,
                -- null_ls.builtins.diagnostics.shellcheck,
                -- viml
                null_ls.builtins.diagnostics.vint,
                null_ls.builtins.diagnostics.vale,
                -- js
                null_ls.builtins.diagnostics.eslint,
            }
        })
    end
}
