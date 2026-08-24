vim.keymap.set("n", "<leader>dn", function()
    local dir = vim.fn.expand("~/Documents/notes")

    -- Create directory if it doesn't exist
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end

    local date_str = os.date("%Y-%m-%d")
    local filepath = dir .. "/" .. date_str .. ".md"

    -- If file doesn't exist, create it with the header
    if vim.fn.filereadable(filepath) == 0 then
        local file = io.open(filepath, "w")
        if file then
            file:write("# Daily Note\n\n")
            file:close()
        end
    end

    -- Edit the file (opens existing or newly created file)
    vim.cmd("edit " .. vim.fn.fnameescape(filepath))
end, { desc = "Open or create today's daily note" })

return {}
