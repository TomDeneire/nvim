return {
    settings = {
        gopls = {
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
            analyses = {
                unusedparams = true,
                shadow = true,
                nilness = true,
                unusedwrite = true,
            },
            codelenses = {
                generate = true,
                gc_details = false,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
        },
    },
}
