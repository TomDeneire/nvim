-- Globals

QtechNG_files = { "*.m", "*.l", "*.x", "*.i", "*.b", "*.d" }

-- Locals
local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

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
    pattern = { ".md", "*.vim", "*.py", "*.lua", "*.go", "*.js", "*.x", "*.rst" },
    callback = require("modules.utils").trim_trailing_whitespace,
})

-- Code action
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.hs" },
    command = "silent! lua vim.lsp.buf.code_action()",
})

-- Qtechng file format
vim.api.nvim_create_autocmd("BufwritePost", {
    pattern = QtechNG_files,
    command = "silent! !qtechng file format --inplace %:p",
})

-- Auto-add path to zoxide
vim.api.nvim_create_autocmd("BufNew", {
    desc = 'Auto-add path to zoxide',
    command = "silent! !zoxide add %:p:h",
})

-- MUMPS
vim.api.nvim_create_autocmd("FileType", {
    pattern = "mfile",
    command = [[inoremap <buffer> <TAB> .]]
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "mfile",
    command = [[noremap <buffer> <c-l> <ESC>:lua require('modules.qtechng').loop_vars()<CR>]]
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "mfile",
    command = [[inoremap <buffer> <CR> <ESC>:lua require('modules.qtechng').mumps_indent()<CR>]]
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "mfile", "xfile" },
    command = [[noremap <buffer> <C-i> <ESC>:lua require('modules.qtechng').show_macro()<CR>]]
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "bfile",
    command = [[noremap <buffer> <C-l> <ESC>:lua require('modules.qtechng').generate_lgcode()<CR>]]
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "mfile",
    command = [[setlocal expandtab shiftwidth=1 softtabstop=1 nowrap]]
})

-- No autoformat in Brocade .py
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.py" },
    callback = function()
        local workspace = vim.fn.getcwd()
        local sourcedir = "/brocade/source/data"
        if string.find(workspace, sourcedir) ~= nil then
            vim.api.nvim_command("FormatDisable")
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
        vim.opt_local.spell = true
    end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = augroup("json_conceal"),
    pattern = { "json", "jsonc", "json5" },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})

return {}
