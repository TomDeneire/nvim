if vim.g.vscode then
    return
end

-- (source editorconfig.nvim)
function Trim_trailing_whitespace()
    local view = vim.fn.winsaveview()
    vim.api.nvim_command("silent! undojoin")
    vim.api.nvim_command("silent keepjumps keeppatterns %s/\\s\\+$//e")
    return vim.fn.winrestview(view)
end

function notification(severity, notify, exclude)
    local level = ""
    if severity == "warn" then
        level = vim.diagnostic.severity.WARN
    elseif severity == "error" then
        level = vim.diagnostic.severity.ERROR
    end
    local notifications = vim.diagnostic.get(0, { severity = level })
    if notifications == nil then
        return
    end
    local notify_messages = ""
    for i in pairs(notifications) do
        local d = notifications[i]
        local code = Split(d.message, " ")
        local code_clean = string.gsub(code[1], " ", "")
        if exclude[code_clean] == nil then
            local n = d.lnum .. ": " .. d.message
            if i ~= Length(notifications) then
                n = n .. "\n"
            end
            notify_messages = notify_messages .. n
        end
    end
    if notify_messages ~= "" then
        local options = { title = "LSP diagnostics", render = "minimal", animate = "static", timeout = false }
        _ = notify(notify_messages, severity, options)
    end
end

-- Display LSP diagnostics in notify
function Diagnostics()
    local notify = require("notify")
    notify.dismiss()
    local exclude = {}
    exclude["E501"] = true
    notification("warn", notify, exclude)
    notification("error", notify, exclude)
end
