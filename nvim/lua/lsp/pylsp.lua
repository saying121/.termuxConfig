return {
    pylsp = {
        plugins = {
            autopep8 = {
                enabled = false,
            },
            -- jedi = {
            --     auto_import_moduls = { 'numpy', 'math' },
            -- },
            -- 不提示格式
            pycodestyle = {
                enabled = false,
            },
            -- rope_autoimport = {
            --     enabled = true,
            --     memory = true,
            -- },
            yapf = {
                enabled = false,
            }
        }
    }
}
