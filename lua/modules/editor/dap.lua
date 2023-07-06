return {
    "leoluz/nvim-dap-go",
    ft = { "go" },
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function()
        require("dapui").setup(
            {
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
                        size = 1
                    },
                        -- {
                        --     id = "breakpoints",
                        --     size = 0.25
                        -- },
                        -- {
                        --     id = "stacks",
                        --     size = 0.25
                        -- },
                        -- {
                        --     id = "watches",
                        --     size = 0.25
                        -- }
                    },
                    position = "bottom",
                    size = 10
                }, {
                    elements = {
                        --     {
                        --     id = "repl",
                        --     size = 0.5
                        -- }, {
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
            }
        )
        require('dap-go').setup {}
        vim.keymap.set("n", "<leader>db", require("dap").toggle_breakpoint,
            { desc = 'DAP toggle breakpoint' })
        vim.keymap.set("n", "<leader>dc", require("dap").continue,
            { desc = 'DAP continue' })
        vim.keymap.set("n", "<leader>do", require("dapui").float_element,
            { desc = 'DAPUI open' })
        vim.keymap.set("n", "<leader>de", require("dapui").eval,
            { desc = 'DAPUI float' })
    end
}
