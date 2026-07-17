return {
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            diagnostics = { globals = { "vim", "Snacks" } },
            hint = {
                enable = true,
                arrayIndex = "Auto",
                setType = false,
                paramName = "All",
                paramType = true,
            },
            completion = { callSnippet = "Replace" },
        },
    },
}
