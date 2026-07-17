local servers = {
    bashls = {},
    gopls = require("modules.lsp.servers.gopls"),
    html = {},
    jsonls = {},
    lemminx = {},
    vtsls = {},
    lua_ls = require("modules.lsp.servers.lua_ls"),
    rust_analyzer = require("modules.lsp.servers.rust_analyzer"),
    taplo = {}, -- toml
    ty = require("modules.lsp.servers.ty"),
    vimls = {},
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        {
            "smjonas/inc-rename.nvim",
            config = function()
                require("inc_rename").setup({
                    input_buffer_type = "snacks",
                })
            end,
        },
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {},
        },
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)

                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
                end

                if client.server_capabilities.codeLensProvider then
                    vim.lsp.codelens.enable(true, { bufnr = event.buf })
                end

                -- Updated helper function to accept an optional 4th argument for extra options
                local nmap = function(keys, func, desc, opts)
                    opts = opts or {}
                    local final_opts = vim.tbl_deep_extend("force", { buffer = event.buf, desc = "LSP: " .. desc }, opts)
                    vim.keymap.set("n", keys, func, final_opts)
                end

                -- actions
                nmap('<C-i>', vim.lsp.buf.hover, 'Hover Documentation')
                nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                nmap("<leader>lsp", vim.diagnostic.open_float, 'LSP open in float')
                nmap("<leader>cl", vim.lsp.codelens.run, '[C]ode [L]ens run')
                nmap("<leader>rn", function()
                    return ":IncRename " .. vim.fn.expand("<cword>")
                end, "[R]e[n]ame", { expr = true })

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
            ensure_installed = vim.list_extend(vim.tbl_keys(servers), { "gofumpt", "stylua" }),
        }

        require("mason-lspconfig").setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        --------------------------------------------------------------------------
        -- LSP servers setup
        --------------------------------------------------------------------------
        for server_name, server_opts in pairs(servers) do
            vim.lsp.config[server_name] = server_opts
        end

        -- Install old :LspInfo commmand for muscle memory
        vim.api.nvim_create_user_command('LspInfo', 'checkhealth vim.lsp', {})
    end,
}
