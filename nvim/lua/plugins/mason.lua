return {
    'williamboman/mason.nvim',
    -- lazy = true,
    cmd = 'Mason',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'jayp0521/mason-null-ls.nvim',
        'jayp0521/mason-nvim-dap.nvim',
    },
    config = function()
        require 'mason'.setup({
            -- Where Mason should put its bin location in your PATH. Can be one of:
            -- - "prepend" (default, Mason's bin location is put first in PATH)
            -- - "append" (Mason's bin location is put at the end of PATH)
            -- - "skip" (doesn't modify PATH)
            ---@type '"prepend"' | '"append"' | '"skip"'
            PATH = "prepend",
            pip = {
                -- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
                upgrade_pip = true,
                -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
                install_args = {
                    "black",
                    "isort",
                    "pynvim"
                },
            },
            -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
            -- debugging issues with package installations.
            log_level = vim.log.levels.INFO,
            max_concurrent_installers = 4,
            -- The provider implementations to use for resolving package metadata (latest version, available versions, etc.).
            -- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
            -- Builtin providers are:
            --   - mason.providers.registry-api (default) - uses the https://api.mason-registry.dev API
            --   - mason.providers.client                 - uses only client-side tooling to resolve metadata
            providers = {
                "mason.providers.registry-api",
            },
            ui = {
                check_outdated_packages_on_open = true,
                -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
                border = "double",
                icons = {
                    package_installed = "???",
                    package_pending = "???",
                    package_uninstalled = "???"
                },
                keymaps = {
                    -- Keymap to expand a package
                    toggle_package_expand = "<CR>",
                    -- Keymap to install the package under the current cursor position
                    install_package = "i",
                    -- Keymap to reinstall/update the package under the current cursor position
                    update_package = "u",
                    -- Keymap to check for new version for the package under the current cursor position
                    check_package_version = "c",
                    -- Keymap to update all installed packages
                    update_all_packages = "U",
                    -- Keymap to check which installed packages are outdated
                    check_outdated_packages = "C",
                    -- Keymap to uninstall a package
                    uninstall_package = "X",
                    -- Keymap to cancel a package installation
                    cancel_installation = "<C-c>",
                    -- Keymap to apply language filter
                    apply_language_filter = "<C-f>",
                },
            },
        })
        require 'mason-lspconfig'.setup({
            ensure_installed = {
                'awk_ls',
                'bashls',
                'emmet_ls',
                'gopls',
                'jdtls',
                'jsonls',
                'pylsp',
                'sqlls',
                'tsserver',
                'vimls',
                'yamlls',
            },
            -- Can either be:
            --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
            --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
            automatic_installation = true,
        })
        require 'mason-null-ls'.setup({
            ensure_installed = {
                'black',
                'isort',
                'prettier',
                'shfmt',
                'sql_formatter',
                'vint',
                'shellcheck'
                -- 'clang-format',
            },
            automatic_installation = true,
            automatic_setup = false,
        })
        require 'mason-nvim-dap'.setup({
            ensure_installed = {
                'bash',
                'delve',
                'javadbg',
                'python',
            },
            -- Can either be:
            --   - { exclude: string[] }: All adapters set up via mason-nvim-dap, except the ones provided in the list, are automatically installed.
            --       Example: automatic_installation = { exclude = { "python", "delve" } }
            automatic_installation = true,
            -- Whether adapters that are installed in mason should be automatically set up in dap.
            -- Removes the need to set up dap manually.
            -- See mappings.adapters and mappings.configurations for settings.
            -- Must invoke when set to true: `require 'mason-nvim-dap'.setup_handlers()`
            -- Can either be:
            -- 	- false: Dap is not automatically configured.
            -- 	- true: Dap is automatically configured.
            -- 	- {adapters: {ADAPTER: {}, }, configurations: {ADAPTER: {}, }}. Allows overriding default configuration.
            automatic_setup = false,
        })
        -- require 'mason-nvim-dap'.setup_handlers()
    end
}
