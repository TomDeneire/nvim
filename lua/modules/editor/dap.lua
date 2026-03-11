return {
    "mfussenegger/nvim-dap",
    ft = { "go", "python" },
    dependencies = {
        "leoluz/nvim-dap-go",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio" },
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
                    options = { source_filetype = 'python' },
                })
            else
                cb({
                    type = 'executable',
                    command = vim.fn.exepath('python3'),
                    args = { '-m', 'debugpy.adapter' },
                    options = { source_filetype = 'python' },
                })
            end
        end

        dap.configurations.python = {
            {
                type = 'python',
                request = 'launch',
                name = "Launch file",
                program = "${file}",
                pythonPath = function()
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                        return cwd .. '/venv/bin/python'
                    elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                        return cwd .. '/.venv/bin/python'
                    else
                        return vim.fn.exepath('python3')
                    end
                end,
            },
        }

        -- UI
        require("dapui").setup({
            controls = {
                element = "repl",
                enabled = true,
                icons = {
                    disconnect = "", pause = "", play = "",
                    run_last = "", step_back = "", step_into = "",
                    step_out = "", step_over = "", terminate = "",
                }
            },
            icons = { collapsed = "", current_frame = "", expanded = "" },
            layouts = { {
                elements = { { id = "scopes", size = 1 } },
                position = "bottom",
                size = 10
            } },
        })

        -- Highlight
        vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = '', numhl = '' })

        -- Keymaps
        vim.keymap.set({ "n", "v" }, "<leader>db", require("dap").toggle_breakpoint,
            { desc = 'DAP toggle breakpoint' })
        vim.keymap.set("n", "<leader>dc", require("dap").continue,
            { desc = 'DAP continue' })
        vim.keymap.set("n", "<leader>do", require("dapui").float_element,
            { desc = 'DAPUI open' })
        vim.keymap.set("n", "<leader>de", require("dapui").eval,
            { desc = 'DAPUI eval' })
        vim.keymap.set("n", "<leader>du", require("dapui").toggle,
            { desc = 'DAPUI toggle' })
    end
}
