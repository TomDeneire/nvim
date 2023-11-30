return {
    "mfussenegger/nvim-dap",
    ft = { "go", "python" },
    dependencies = {
        "leoluz/nvim-dap-go",
        "rcarriga/nvim-dap-ui" },
    config = function()
        local dap = require('dap')

        -- Go
        require('dap-go').setup {}

        -- Python
        dap.adapters.python = function(cb, config)
            if config.request == 'attach' then
                ---@diagnostic disable-next-line: undefined-field
                local port = (config.connect or config).port
                ---@diagnostic disable-next-line: undefined-field
                local host = (config.connect or config).host or '127.0.0.1'
                cb({
                    type = 'server',
                    port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                    host = host,
                    options = {
                        source_filetype = 'python',
                    },
                })
            else
                cb({
                    type = 'executable',
                    command = 'py3',
                    args = { '-m', 'debugpy.adapter' },
                    options = {
                        source_filetype = 'python',
                    },
                })
            end
        end

        dap.configurations.python = {
            {
                -- The first three options are required by nvim-dap
                type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
                request = 'launch',
                name = "Launch file",

                -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                program = "${file}", -- This configuration will launch the current file if used.
                pythonPath = function()
                    -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                    -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                    -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                        return cwd .. '/venv/bin/python'
                    elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                        return cwd .. '/.venv/bin/python'
                    else
                        return 'py3'
                    end
                end,
            },
        }

        -- UI
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

        -- Highlight
        vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = '', numhl = '' })

        -- Keymaps
        vim.keymap.set({ "n", "v" }, "<leader>db", require("dap").toggle_breakpoint,
            { desc = 'DAP toggle breakpoint' })
        vim.keymap.set("n", "<leader>dc", require("dap").continue,
            { desc = 'DAP continue' })
        vim.keymap.set("n", "<leader>do", require("dapui").float_element,
            { desc = 'DAPUI open' })
        vim.keymap.set("n", "<leader>de", require("dapui").eval,
            { desc = 'DAPUI float' })
    end
}
