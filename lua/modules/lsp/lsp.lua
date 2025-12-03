local servers = {
    bashls = {},
    -- copilot = {},
    elixirls = { cmd = { "/home/tdeneire/bin/language_server.sh" } },
    gopls = {},
    html = {},
    jsonls = {},
    lemminx = {},
    ts_ls = {},
    lua_ls = {
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        },
    },
    pyright = {},
    rust_analyzer = {},
    taplo = {},
    vimls = {},
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
            callback = function(event)
                local nmap = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                nmap('<c-D>', require('telescope.builtin').lsp_definitions, 'Goto [D]efinition')
                nmap("<leader>f", vim.lsp.buf.format, 'Format')
                nmap("<leader>lsp", vim.diagnostic.open_float, 'LSP open in float')
                nmap('<C-i>', vim.lsp.buf.hover, 'Hover Documentation')
                nmap('<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

                --
                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })
            end,
        })

        --------------------------------------------------------------------------
        -- Mason setup
        --------------------------------------------------------------------------
        require("mason").setup()

        require("mason-tool-installer").setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        require("mason-lspconfig").setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        --------------------------------------------------------------------------
        -- LSP servers setup
        --------------------------------------------------------------------------

        for server_name, opts in pairs(servers) do
            vim.lsp.config[server_name] = { opts }
        end
    end,
}
