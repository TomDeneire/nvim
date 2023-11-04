-- LSP settings.

local on_attach = function(client, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.

    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        if client.name == "ruff_lsp" then
            client.server_capabilities.hoverProvider = false
        end
    end

    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    nmap('<c-D>', require('telescope.builtin').lsp_definitions, 'Goto [D]efinition')
    nmap("<leader>f", vim.lsp.buf.format, 'Format')
    nmap("<leader>lsp", vim.diagnostic.open_float, 'LSP open in float')
    nmap('<C-i>', vim.lsp.buf.hover, 'Hover Documentation')

    nmap('<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
        '[W]orkspace [S]ymbols')
    nmap('<leader>rn', vim.lsp.buf.rename, "LSP rename")

    -- -- Lesser used LSP functionality
    -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    -- nmap('<leader>wl', function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, '[W]orkspace [L]ist Folders')
    --
    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    bashls = {},
    gopls = {},
    golangci_lint_ls = {},
    html = {},
    jsonls = {},
    pyright = {},
    intelephense = {},
    ruff_lsp = {},
    marksman = {},
    -- rust_analyzer = {},
    -- tsserver = {},
    vimls = {},
    -- hls = {},
    elixirls = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- Disable LSP diagnostic virtual text (because of LSP diagnostics in notify)
-- vim.diagnostic.config({ virtual_text = false })

return {
    'neovim/nvim-lspconfig',
    event = "BufReadPre",
    dependencies = {
        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
        -- Automatically install LSPs to stdpath for neovim
        { 'williamboman/mason.nvim', build = ':MasonUpdate', config = true },
        {
            'williamboman/mason-lspconfig.nvim',
            config = function()
                -- Setup neovim lua configuration
                require('neodev').setup()

                -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
                local capabilities = vim.lsp.protocol.make_client_capabilities()
                capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

                -- Ensure the servers above are installed
                require("mason").setup()
                local mason_lspconfig = require 'mason-lspconfig'

                mason_lspconfig.setup {
                    ensure_installed = vim.tbl_keys(servers),
                }

                -- Do this before setup_handlers!
                require 'lspconfig'.elixirls.setup {
                    cmd = { '/home/tdeneire/bin/language_server.sh' },
                    on_attach = on_attach,
                    capabilities = capabilities,
                }

                mason_lspconfig.setup_handlers {
                    function(server_name)
                        require('lspconfig')[server_name].setup {
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = servers[server_name],
                        }
                    end,
                }
            end
        }
    }
}
