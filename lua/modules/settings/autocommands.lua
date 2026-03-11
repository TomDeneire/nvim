-- Locals
local function augroup(name)
    return vim.api.nvim_create_augroup("spunkshui_" .. name, { clear = true })
end

local function trim_trailing_whitespace()
    -- (source editorconfig.nvim)
    local view = vim.fn.winsaveview()
    vim.api.nvim_command("silent! undojoin")
    vim.api.nvim_command("silent keepjumps keeppatterns %s/\\s\\+$//e")
    return vim.fn.winrestview(view)
end

-- Normalize to unix: set fileformat and strip any embedded \r from pasted text
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.bo.fileformat = "unix"
        local view = vim.fn.winsaveview()
        vim.cmd("silent keepjumps keeppatterns %s/\\r//e")
        vim.fn.winrestview(view)
    end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Trim trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { ".md", "*.vim", "*.py", "*.lua", "*.go", "*.js", "*.rst" },
    callback = trim_trailing_whitespace,
})

-- Auto-add path to zoxide
vim.api.nvim_create_autocmd("BufNew", {
    desc = 'Auto-add path to zoxide',
    callback = function()
        local dir = vim.fn.expand("%:p:h")
        if dir ~= "" then
            vim.fn.jobstart({ "zoxide", "add", dir }, { detach = true })
        end
    end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "grug-far",
        "help",
        "lspinfo",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
        "dbout",
        "gitsigns.blame",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", {
            buffer = event.buf,
            silent = true,
            desc = "Quit buffer",
        })
    end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        -- set to false (because Dutch vs English conflicts)
        vim.opt_local.spell = false
    end,
})

return {}
