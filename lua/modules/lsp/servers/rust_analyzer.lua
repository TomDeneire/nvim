return {
    settings = {
        ["rust-analyzer"] = {
            inlayHints = {
                bindingModeHints = { enable = false },
                closureReturnTypeHints = { enable = "with_block" },
                lifetimeElisionHints = { enable = "skip_trivial" },
                typeHints = { enable = true },
                parameterHints = { enable = true },
                chainingHints = { enable = true },
            },
            procMacro = { enable = true },
            diagnostics = { disabled = { "unresolved-proc-macro" } },
            lens = { enable = true },
        },
    },
    commands = {
        ["rust-analyzer.showReferences"] = function(command, ctx)
            local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
            local file_uri, position, references = unpack(command.arguments)

            vim.fn.setqflist({}, ' ', {
                title = command.title,
                items = vim.lsp.util.locations_to_items(references, client.offset_encoding),
            })

            vim.lsp.util.show_document({
                uri = file_uri,
                range = { start = position, ["end"] = position },
            }, client.offset_encoding)

            vim.cmd('botright copen')
        end,
    },
}
