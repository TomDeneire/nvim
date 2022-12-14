---@diagnostic disable: undefined-global
function JumpToRou()
    local mroutine = vim.g.mrou
    local t = {}
    for str in string.gmatch(mroutine, "([^" .. "^" .. "]+)") do
        table.insert(t, str)
    end
    local l = {}
    local mlabel = t[1]
    for str in string.gmatch(mlabel, "([^" .. "$$" .. "]+)") do
        table.insert(l, str)
    end
    if l[2] ~= nil then
        mlabel = l[2]
    end
    vim.g.mlabel = mlabel
    local mfile = t[2]
    vim.g.jumpexe = "echo $(qtechng registry get qtechng-work-dir)$(qtechng registry get os-sep)$(jq -r '." ..
        '"' ..
        mfile ..
        '.m"' ..
        "' $(qtechng registry get qtechng-support-dir)/m_unique_map.json)$(qtechng registry get os-sep)" ..
        mfile .. ".m"
end
