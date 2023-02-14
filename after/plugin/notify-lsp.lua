if vim.g.vscode then
    return
end

-- Diagnostic severity table
Severity = { warn = vim.diagnostic.severity.WARN,
    info = vim.diagnostic.severity.INFO,
    hint = vim.diagnostic.severity.HINT,
    error = vim.diagnostic.severity.ERROR }

-- Show notifications
function notify_lsp_diagnostics(config)
    -- Clear previous notifications
    local notify = require("notify")
    notify.dismiss()
    -- Handle LSP diagnostic severity_levels
    for level in pairs(config.severity_levels) do
        if config.severity_levels[level] == true then
            local notifications = vim.diagnostic.get(
                0, { severity = Severity[level] })
            if notifications ~= nil then
                local notify_textbox = ""
                for j in pairs(notifications) do
                    local d = notifications[j]
                    local code = Split(d.message, " ")
                    local code_clean = string.gsub(code[1], " ", "")
                    if config.exclude_codes[code_clean] == nil then
                        local n = d.lnum + 1 .. ": " .. d.message
                        if j ~= Length(notifications) then
                            n = n .. "\n"
                        end
                        notify_textbox = notify_textbox .. n
                    end
                end
                if notify_textbox ~= "" then
                    _ = notify(notify_textbox, level, config["notify_options"])
                end
            end
        end
    end
end

-- User config
local exclude_codes = {} -- e.g. E501
exclude_codes["E501"] = true

local severity_levels = {} -- info, hint, warn, error
severity_levels["info"] = false
severity_levels["hint"] = false
severity_levels["warn"] = true
severity_levels["error"] = true

local options = {
    title = "LSP diagnostics",
    render = "minimal", -- "default", "minimal", "simple", "compact"
    animate = "static", -- "fade_in_slide_out", "fade", "slide", "static",
    timeout = false -- boolean, int
}

Config = {
    exclude_codes = exclude_codes,
    severity_levels = severity_levels,
    notify_options = options
}


-- Display LSP diagnostics with nvim-notify
function Diagnostics()
    notify_lsp_diagnostics(Config)
end
