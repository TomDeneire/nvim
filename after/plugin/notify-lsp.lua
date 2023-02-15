if vim.g.vscode then
    return
end

-- Diagnostic severity table
Severity = { warn = vim.diagnostic.severity.WARN,
    info = vim.diagnostic.severity.INFO,
    hint = vim.diagnostic.severity.HINT,
    error = vim.diagnostic.severity.ERROR }

-- Diagnostic icons
Icons = {
    debug = "",
    error = "",
    info = "",
    hint = "",
    trace = "✎",
    warn = ""
}

-- Split up longer lines by inserting newlines
local function insertNewLines(message)
    message = string.gsub(message, "\n", " ")
    message = string.gsub(message, "\r\n", " ")
    message = string.gsub(message, "\t", " ")
    if string.len(message) < 50 then
        return message
    end
    local new_message = ""
    local line = ""
    local words = Split(message, " ")
    for i in pairs(words) do
        if string.len(line) > 50 then
            new_message = new_message .. line .. "\n"
            line = ""
        end
        line = line .. " " .. words[i]
    end
    new_message = new_message .. " " .. line
    new_message = string.gsub(new_message, "  ", " ")
    if string.sub(new_message, 1, 1) == " " then
        new_message = string.sub(new_message, 2, string.len(new_message))
    end
    local first = string.sub(new_message, 1, 1)
    new_message = string.upper(first) .. string.sub(new_message, 2, string.len(new_message))
    return new_message
end

-- Show notifications
local function notify_lsp_diagnostics(config)
    -- Clear previous notifications
    local notify = require("notify")
    notify.dismiss()
    -- Handle LSP diagnostic severity_levels
    for level in pairs(config.severity_levels) do
        if config.severity_levels[level] == true then
            local diagnostics = vim.diagnostic.get(
                0, { severity = Severity[level] })
            if diagnostics ~= nil then
                local notify_textbox = ""
                for j in pairs(diagnostics) do
                    local diagnostic = diagnostics[j]
                    local code = Split(diagnostic.message, " ")
                    local code_clean = string.gsub(code[1], " ", "")
                    if config.exclude_codes[code_clean] == nil then
                        local message = insertNewLines(diagnostic.message)
                        local n = ""
                        if config.notify_options.render == "minimal" then
                            n = Icons[level] .. " "
                        end
                        n = n .. diagnostic.lnum + 1 .. ": " .. message
                        if j ~= Length(diagnostics) then
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
local function get_user_config()

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
        animate = "static", -- "fade_in_slide_out", "fade", "slide", "static"
        timeout = false -- boolean, int
    }

    local config = {
        exclude_codes = exclude_codes,
        severity_levels = severity_levels,
        notify_options = options
    }

    return config
end

-- Display LSP diagnostics with nvim-notify
function Diagnostics()

    local config = get_user_config()
    notify_lsp_diagnostics(config)
end
