return {
    'mfussenegger/nvim-dap',
    lazy = true,
    -- event = 'VimEnter',
    keys = {
        { '<space>b',   mode = 'n' },
        { '<space>B',   mode = 'n' },
        { '<leader>tb', mode = 'n' },
        { '<leader>sc', mode = 'n' },
        { '<leader>cl', mode = 'n' },
    },
    cmd = {
        'PBToggleBreakpoint',
        'PBClearAllBreakpoints',
        'PBSetConditionalBreakpoint',
    },
    config = function()
        -- 对各个语言的配置
        require 'dap-conf.python'
        require 'dap-conf.c'
        -- ---------------------------------------------------

        vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
        vim.fn.sign_define('DapStopped', { text = '⭐️', texthl = '', linehl = '', numhl = '' })

        local dap = require('dap')
        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true }

        keymap('n', '<space>b', dap.toggle_breakpoint, opts)
        keymap('n', '<space>B', "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)

        keymap({ 'n', 'i', 't' }, '<F5>', dap.continue, opts)
        keymap({ 'n', 'i', 't' }, '<F6>', dap.step_into, opts)
        keymap({ 'n', 'i', 't' }, '<F7>', dap.step_over, opts)
        keymap({ 'n', 'i', 't' }, '<F8>', dap.step_out, opts)
        keymap({ 'n', 'i', 't' }, '<F9>', dap.step_back, opts)
        keymap({ 'n', 'i', 't' }, '<F10>', dap.run_last, opts)
        keymap({ 'n', 'i', 't' }, "<F11>", dap.terminate, opts)

        keymap('n', '<space>lp',
            "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
        keymap('n', '<space>dr', dap.repl.open, opts)
        keymap('n', '<space>dl', dap.run_last, opts)

        -- local dap = require('dap')
        local dapui = require('dapui')
        -- 自动开启ui
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
            vim.api.nvim_command("DapVirtualTextEnable")
        end
        -- 自动关闭ui
        dap.listeners.before.event_terminated["dapui_config"] = function()
            vim.api.nvim_command("DapVirtualTextEnable")
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            vim.api.nvim_command("DapVirtualTextEnable")
            dapui.close()
        end
        dap.listeners.before.disconnect["dapui_config"] = function()
            vim.api.nvim_command("DapVirtualTextEnable")
            dapui.close()
        end
        -- TODO wait dap-ui for fix terminal layout
        dap.defaults.fallback.terminal_win_cmd = 'set splitright | 10vsplit new' -- this will be override by dapui
        -- dap.defaults.python.terminal_win_cmd = 'set splitright | 2vsplit new' -- 终端会被移动，这个数值不准确
        dap.defaults.fallback.focus_terminal = false
        dap.defaults.fallback.force_external_terminal = false
    end,
    dependencies = {
        {
            'rcarriga/cmp-dap',
            config = function()
                require("cmp").setup({
                    enabled = function()
                        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
                            or require("cmp_dap").is_dap_buffer()
                    end
                })

                require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
                    sources = {
                        { name = "dap" },
                    },
                })
            end
        },
        {
            'rcarriga/nvim-dap-ui',
            config = function()
                local dapui, keymap = require('dapui'), vim.keymap.set
                local opts          = { noremap = true, silent = true }
                keymap('v', '<space>e', dapui.eval, opts)
                keymap('n', '<space>e', dapui.eval, opts)

                keymap({ 'n', 't' }, '<space>dt', dapui.toggle, opts)

                require("dapui").setup({
                    controls = {
                        element = "repl",
                        enabled = true,
                        icons = {
                            disconnect = "",
                            pause = "",
                            play = "",
                            run_last = "",
                            step_back = "",
                            step_into = "",
                            step_out = "",
                            step_over = "",
                            terminate = ""
                        }
                    },
                    element_mappings = {},
                    expand_lines = true,
                    floating = {
                        border = "single",
                        mappings = {
                            close = { "q", "<Esc>" }
                        }
                    },
                    force_buffers = true,
                    icons = {
                        collapsed = "",
                        current_frame = "",
                        expanded = ""
                    },
                    layouts = { {
                        elements = { {
                            id = "scopes",
                            size = 0.25
                        }, {
                            id = "breakpoints",
                            size = 0.25
                        }, {
                            id = "stacks",
                            size = 0.25
                        }, {
                            id = "watches",
                            size = 0.25
                        } },
                        position = "left",
                        size = 40
                    }, {
                        elements = { {
                            id = "repl",
                            size = 1
                        },
                            -- {
                            --     id = "console",
                            --     size = 0.5
                            -- }
                        },
                        position = "bottom",
                        size = 10
                    } },
                    mappings = {
                        edit = "e",
                        expand = { "<CR>", "<2-LeftMouse>" },
                        open = "o",
                        remove = "d",
                        repl = "r",
                        toggle = "t"
                    },
                    render = {
                        indent = 1,
                        max_value_lines = 100
                    }
                })
            end,
        },
        {
            'theHamsta/nvim-dap-virtual-text',
            config = function()
                require("nvim-dap-virtual-text").setup {
                    enabled = true,
                    enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
                    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
                    highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
                    show_stop_reason = true, -- show stop reason when stopped for exceptions
                    commented = false, -- prefix virtual text with comment string
                    only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
                    all_references = false, -- show virtual text on all all references of the variable (not only definitions)
                    filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
                    -- experimental features:
                    virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
                    all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
                    virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
                    virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
                    -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
                }
            end,
        },
        {
            'Weissle/persistent-breakpoints.nvim',
            config = function()
                require('persistent-breakpoints').setup {
                    save_dir = vim.fn.stdpath('data') .. '/nvim_checkpoints',
                    -- load_breakpoints_event = { "BufReadPost" },
                    -- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
                    perf_record = false,
                }
                local opts = { noremap = true, silent = true }
                local keymap = vim.api.nvim_set_keymap
                -- Save breakpoints to file automatically.
                keymap("n", "<leader>tb", "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>", opts)
                keymap("n", "<leader>sc",
                    "<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<cr>", opts)
                keymap("n", "<leader>cl", "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>",
                    opts)
            end,
        },
    },
}
