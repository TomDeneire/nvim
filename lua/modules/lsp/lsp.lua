local servers = {
    bashls = {},
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

                -- actions
                nmap('<C-i>', vim.lsp.buf.hover, 'Hover Documentation')
                nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                nmap("<leader>f", vim.lsp.buf.format, 'Format')
                nmap("<leader>lsp", vim.diagnostic.open_float, 'LSP open in float')
                nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                -- goto
                -- (usually there's only one, but several are possible, hence these use a picker)
                nmap('<C-d>', function() Snacks.picker.lsp_definitions() end, 'Goto [D]efinition(s)')
                nmap('gd', function() Snacks.picker.lsp_type_definitions() end, 'Goto Type [D]efinition(s)')
                nmap('gD', function() Snacks.picker.lsp_declarations() end, 'Goto [D]eclaration(s)')
                nmap("gI", function() Snacks.picker.lsp_implementations() end, "LSP Implementations")
                -- lists
                nmap('gr', function() Snacks.picker.lsp_references() end, 'LSP References')
                nmap("gs", function() Snacks.picker.lsp_symbols() end, "LSP Document Symbols")
                nmap("gS", function() Snacks.picker.workspace_symbols() end, "LSP Workspace Symbols")
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
