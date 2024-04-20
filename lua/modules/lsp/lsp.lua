-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
local servers = {
    bashls = {},
    elixirls = {
        cmd = { '/home/tdeneire/bin/language_server.sh' },
    },
    gopls = {},
    golangci_lint_ls = {},
    -- hls = {},
    html = {},
    intelephense = {},
    jsonls = {},
    lemminx = {},
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    version = 'Lua 5.4',
                    path = {
                        '?.lua',
                        '?/init.lua',
                        vim.fn.expand '~/.luarocks/share/lua/5.4/?.lua',
                        vim.fn.expand '~/.luarocks/share/lua/5.4/?/init.lua',
                        '/usr/share/5.4/?.lua',
                        '/usr/share/lua/5.4/?/init.lua'
                    }
                },
                workspace = {
                    library = {
                        vim.fn.expand '~/.luarocks/share/lua/5.4',
                        '/usr/share/lua/5.4'
                    }
                }
            }
        }
    },
    marksman = {},
    -- see https://github.com/microsoft/pyright/blob/main/docs/configuration.md
    pyright = {
        settings = {
            pyright = {
                -- disableLanguageServices = false,
                -- disableOrganizeImports = true,
            },
            python = {
                -- pythonPath = vim.g.python3_host_prog,
                analysis = {
                    autoSearchPaths = true,
                    autoImportCompletion = true,
                    diagnosticMode = "openFilesOnly",
                    pythonPlatform = "linux",
                    diagnosticSeverityOverrides = {
                        reportGeneralTypeIssues = "warning",
                        reportOptionalCall = "warning",
                        -- reportOptionalMemberAccess = "none",
                        -- reportOptionalSubscript = "none",
                        -- reportPrivateImportUsage = "none",
                        -- reportIndexIssue = "none",
                        -- reportRedeclaration = "none",
                        reportArgumentType = "warning",
                        -- reportAssignmentType = "information",
                        -- reportCallIssue = "none",
                        reportReturnType = "warning",
                        -- reportAttributeAccessIssue = "none",
                    },
                },
            }
        }
    },
    rust_analyzer = {},
    taplo = {},
    -- tsserver = {},
    vimls = {},
}

return { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for neovim
        { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
        --  This function gets run when an LSP attaches to a particular buffer.
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('spunkshui-lsp-attach', { clear = true }),
            callback = function(event)
                local nmap = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
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
                nmap('<leader>rn', vim.lsp.buf.rename, "LSP rename")
                nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                --
                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })
            end,
        })

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP Specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend(
            'force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        local servers = servers

        -- Ensure the servers and tools above are installed
        --  To check the current status of installed tools and/or manually install
        --  other tools, you can run
        --    :Mason
        --
        --  You can press `g?` for help in this menu
        require('mason').setup()

        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        -- vim.list_extend(ensure_installed, {
        --     'stylua', -- Used to format lua code
        -- })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require('mason-lspconfig').setup {
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for tsserver)
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        }
    end,
}
