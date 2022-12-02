if not vim.g.vscode
    then
    -- first setup mason

    require("mason").setup()

    require("mason-lspconfig").setup()

    require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {}
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ["rust_analyzer"] = function ()
        --     require("rust-tools").setup {}
        -- end
    }

    -- lspconfig see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

    -- Autocomplete
    local lspkind = require('lspkind')
    local cmp = require'cmp'

      cmp.setup({
        formatting = {
            format = lspkind.cmp_format({
              -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
              mode = 'symbol_text', -- show only symbol annotations
              maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

              -- The function below will be called before any actual modifications from lspkind
              -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
              before = function (entry, vim_item)
                -- ...
                return vim_item
              end
            })
          },
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        completion = {keyword_length = 2},
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' }, -- For vsnip users.
          -- { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = 'buffer' },
        })
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- LSP
    --
    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    --local opts = { noremap=true, silent=true }
    --vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    --vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    --vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    --vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    --
    --  -- Mappings.
    --  -- See `:help vim.lsp.*` for documentation on any of the below functions
    --  local bufopts = { noremap=true, silent=true, buffer=bufnr }
    --  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    --  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    --  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    --  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    --  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    --  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    --  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    --  vim.keymap.set('n', '<space>wl', function()
    --    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --  end, bufopts)
    --  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    --  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    --  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    --  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    --  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    end


    require'lspconfig'.pylsp.setup{
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        pylsp = {
          plugins = {
            pycodestyle = {
              ignore = {'W391'},
              maxLineLength = 100
            }
          }
        }
      }
    }
    require'lspconfig'.marksman.setup{on_attach = on_attach, capabilities = capabilities}

    require'lspconfig'.gopls.setup{on_attach = on_attach, capabilities = capabilities}

    require'lspconfig'.tsserver.setup{
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
    }
end
