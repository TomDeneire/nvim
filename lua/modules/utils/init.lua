local M = {}


-- (source editorconfig.nvim)
function M.trim_trailing_whitespace()
    local view = vim.fn.winsaveview()
    vim.api.nvim_command("silent! undojoin")
    vim.api.nvim_command("silent keepjumps keeppatterns %s/\\s\\+$//e")
    return vim.fn.winrestview(view)
end

function M.restore_session()
    require('persistence').load({ last = true })
end

-- Telescope specific functions

local function _getfinddir()
    local workspace = vim.fn.getcwd()
    local code_work_dir = "/home/tdeneire/projects/code"
    local notes_work_dir = "/mnt/c/Users/TDN/OneDrive - Verhelst Aannemingen/Notes"
    if string.find(workspace, "Aannemingen/Notes") ~= nil then
        return notes_work_dir
    elseif string.find(workspace, "projects/code") ~= nil then
        return code_work_dir
    else
        return workspace
    end
end

local find_command = { "rg", "--smart-case", "--files", "--no-search-zip" }

local function _get_find_opts()
    return {
        hidden = true,
        find_command = find_command,
        no_ignore = true,
        no_ignore_parent = true,
        cwd = _getfinddir()
    }
end

function M.find_in_workspace()
    require("telescope.builtin").find_files(_get_find_opts())
end

function M.grep_in_workspace()
    require("telescope.builtin").live_grep(_get_find_opts())
end

function M.grep_yanked()
    local text = vim.fn.getreg("")
    text = string.lower(text)
    local grep_opts = _get_find_opts()
    grep_opts["search"] = text
    require("telescope.builtin").grep_string(grep_opts)
end

function M.grep_pattern()
    local pattern = vim.fn.input("Grep_pattern=", "*.")
    local grep_opts = _get_find_opts()
    grep_opts["glob_pattern"] = pattern
    require("telescope.builtin").live_grep(grep_opts)
end

function M.lsp_filetypes()
    return { "lua", "go", "javascript", "python", "xml", "html",
        "markdown", "css", "php", "phtml", "json", "typescript",
        "rst", "vim", "haskell", "rust", "bash", "elixir", "toml", "yaml" }
end

-- Open wezterm in cwd
function M.wezterm_open()
    local cmd = { 'wezterm', 'start', '--cwd', vim.fn.getcwd() }
    -- function from /home/tdeneire/.local/share/nvim/lazy/lazy.nvim/lua/lazy/util.lua
    require('lazy.util').float_term(cmd, { size = { width = 0.9, height = 0.9 } })
end

return M
