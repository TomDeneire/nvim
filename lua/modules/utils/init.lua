local M = {}


-- (source editorconfig.nvim)
function M.trim_trailing_whitespace()
    local view = vim.fn.winsaveview()
    vim.api.nvim_command("silent! undojoin")
    vim.api.nvim_command("silent keepjumps keeppatterns %s/\\s\\+$//e")
    return vim.fn.winrestview(view)
end

function M.restore_session()
    vim.api.nvim_command("NoNeckPain")
    vim.api.nvim_command("lua require('persistence').load({ last = true })")
    vim.api.nvim_command("NoNeckPain")
end

-- Telescope specific functions

local function _getfinddir()
    local workspace = vim.fn.getcwd()
    local sourcedir = "/brocade/source/data"
    local packagesdir = "/brocade/packages"
    local qtechng_work_dir = "/home/tdeneire/projects/brocade/source/data"
    local packages_work_dir = "/home/tdeneire/projects/brocade/packages"
    local projects_work_dir = "/home/tdeneire/projects/code"
    local websites_work_dir = "/home/tdeneire/Dropbox/websites"
    if string.find(workspace, sourcedir) ~= nil then
        return qtechng_work_dir
    elseif string.find(workspace, packagesdir) ~= nil then
        return packages_work_dir
    elseif string.find(workspace, websites_work_dir) ~= nil then
        return websites_work_dir
    else
        return projects_work_dir
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

return M
