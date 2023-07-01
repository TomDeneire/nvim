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

local find_opts = {
    hidden = true,
    find_command = find_command,
    no_ignore = true,
    no_ignore_parent = true,
    cwd = _getfinddir()
}

function Find_in_workspace()
    require("telescope.builtin").find_files(find_opts)
end

function Grep_in_workspace()
    require("telescope.builtin").live_grep(find_opts)
end

function Grep_yanked()
    local text = vim.fn.getreg("")
    text = string.lower(text)
    local grep_opts = find_opts
    grep_opts["search"] = text
    require("telescope.builtin").grep_string(grep_opts)
end

function Grep_pattern()
    local pattern = vim.fn.input("Grep_pattern=", "*.")
    local grep_opts = find_opts
    grep_opts["glob_pattern"] = pattern
    require("telescope.builtin").live_grep(grep_opts)
end

return {}
