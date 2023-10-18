---@diagnostic disable: undefined-global

--REGISTRY GLOBALS

OS_SEP = "$(qtechng registry get os-sep)"
WORK_DIR = "$(qtechng registry get qtechng-work-dir)"
SUPPORT_DIR = "$(qtechng registry get qtechng-support-dir)"
MACRO_DIR = "/home/tdeneire/Dropbox/brocade/support/macros"

-- FUNCTIONS

local M = {}

local function _split(mystring, delim)
    local result = {}
    local start = 1

    while (true) do
        local _, pos = string.find(mystring, delim, start, true)
        if pos == nil then
            local rest = string.sub(mystring, start, string.len(mystring))
            table.insert(result, rest)
            break
        else
            local matchlen = pos - string.len(delim)
            local part = string.sub(mystring, start, matchlen)
            start = pos + 1
            table.insert(result, part)
        end
    end

    return result
end

local function _rstrip(mystring, delim)
    local length = string.len(mystring)
    local minus_one = string.sub(mystring, 1, length - 1)
    if minus_one .. delim == mystring then
        return _rstrip(minus_one, delim)
    else
        return mystring
    end
end

local function _file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

local function _lines_from(file)
    -- Get all lines from a file
    if not _file_exists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do
        table.insert(lines, line)
    end
    return lines
end

local function _get_max_line_length(lines)
    local max_len = 0
    for _, line in ipairs(lines) do
        local line_len = #line
        local tabs = _split(line, "\t")
        line_len = line_len + (#tabs * 4)
        if line_len > max_len then max_len = line_len end
    end
    return max_len
end

function M.show_macro(macro)
    if macro == nil then
        macro = vim.fn.expand("<cword>")
        if string.find(macro, "m4_") == nil then
            return
        end
    end
    local buf = vim.api.nvim_create_buf(false, true)
    local curpos = vim.fn.getcurpos()
    local content = _lines_from(MACRO_DIR .. "/" .. macro .. ".d")
    local max_line_length = _get_max_line_length(content)
    local opts = {
        relative = 'win',
        row = curpos[2],
        col = curpos[3],
        width = max_line_length,
        height = #content
    }
    vim.api.nvim_buf_set_lines(buf, 0, 1, false, content)
    vim.bo[buf].filetype = "dfile"
    local win = vim.api.nvim_open_win(buf, 1, opts)
end

function M.jump_to_routine()
    --"d %CSV^ucsvsbld($file,$exec,$delimiter,$mode,$encoding,$fieldnames)»
    --"«s $error=$$%ChckTyp^barsrou($type,$context,$user)»"
    -- action = "d %Lst^blicjapi"
    local mroutine = vim.fn.expand("<cWORD>")
    mroutine = string.gsub(mroutine, "'", "")
    mroutine = string.gsub(mroutine, '"', "")
    mroutine = string.gsub(mroutine, 'm4_Routine.', "")
    mroutine = _rstrip(mroutine, ")")
    mroutine = _rstrip(mroutine, ",")
    local m = _split(mroutine, "(")
    mroutine = m[1]
    local t = _split(mroutine, "^")
    local mlabel = t[1]
    local l = _split(mlabel, "$$")
    if l[2] ~= nil then
        mlabel = l[2]
    end
    local mfile = t[2] .. ".m"
    local jumpcmd = "echo "
    jumpcmd = jumpcmd .. WORK_DIR
    jumpcmd = jumpcmd .. OS_SEP
    jumpcmd = jumpcmd .. "$(jq -r '." .. '"' .. mfile .. '"' .. "' "
    jumpcmd = jumpcmd .. SUPPORT_DIR .. OS_SEP .. "m_unique_map.json)"
    jumpcmd = jumpcmd .. OS_SEP .. mfile
    local resultfile = vim.fn.system(jumpcmd)
    local cmd = "e +/" .. mlabel .. " " .. resultfile
    vim.cmd(cmd)
end

function M.jump_to_macro_definition()
    -- m4_getCensorType(type,loi)
    -- m4_documentElementInputDate()
    -- m4_documentElementRootStart
    -- m4_zever
    local wordUnderCursor = vim.fn.expand("<cword>")
    if string.find(wordUnderCursor, "m4_") == nil then
        return
    end
    local t = _split(wordUnderCursor, "m4_")
    local macro_name = t[2]
    local macrocmd = "echo "
    macrocmd = macrocmd .. WORK_DIR
    macrocmd = macrocmd .. "$(jq -r ." .. '"' .. macro_name .. '" '
    macrocmd = macrocmd .. SUPPORT_DIR .. OS_SEP .. "m4_map.json)"
    local macro_file = vim.fn.system(macrocmd)
    local macro_file_len = string.len(macro_file)
    local exists = string.sub(macro_file, macro_file_len - 4, macro_file_len)
    exists = string.gsub(exists, "\n", "")
    if exists == "null" then
        return
    end
    local cmd = "e +/" .. macro_name .. "[(:] " .. macro_file
    vim.cmd(cmd)
end

function M.source_list()
    local pattern = vim.fn.input("Search QtechNG repository = ", "")
    local listcmd = "qtechng source list --smartcase --jsonpath=$..DATA..fileurl --needle=" ..
        pattern .. " | awk -F 'file://' '{print $2}' | awk -F '\"' '{print $1}'"
    local result = vim.fn.system(listcmd)
    local t = {}
    for str in string.gmatch(result, "([^" .. "\n" .. "]+)") do
        local file = {}
        file["filename"] = str
        file["pattern"] = pattern
        table.insert(t, file)
    end
    if next(t) then
        vim.fn.setqflist({}, " ", {
            items = t
        })
        require("telescope.builtin").quickfix({ fname_width = 100 })
    end
end

function M.macro_list()
    require("telescope.builtin").find_files(
        {
            hidden = true,
            find_command = { "rg", "--smart-case", "--files" },
            no_ignore = true,
            no_ignore_parent = true,
            cwd = "/home/tdeneire/Dropbox/brocade/support/macros"
        })
end

function M.open_in_git_browser()
    local current_file = vim.fn.expand("%:p")
    local gitcmd = "sensible-browser $(qtechng file tell " .. current_file
    gitcmd = gitcmd .. " --jsonpath='$..DATA..vcurl' --unquote)"
    io.popen(gitcmd)
end

function M.compare_previous()
    local current_file = vim.fn.expand("%:p")
    local cmd = "export QPATH=$(qtechng file tell " .. current_file
    cmd = cmd .. " --jsonpath='$..DATA..qpath' --unquote) "
    cmd = cmd .. "&& export PREVIOUS=$(qtechng registry get qtechng-releases "
    cmd = cmd .. "| awk '{print $(NF-1)}') "
    cmd = cmd .. "&& mkdir -p $PREVIOUS && cd $PREVIOUS && "
    cmd = cmd .. "qtechng source co $QPATH --version=$PREVIOUS "
    cmd = cmd .. "&& meld $PREVIOUS/$(qtechng file tell " .. current_file
    cmd = cmd .. " --jsonpath='$..DATA..relpath' --unquote) "
    cmd = cmd .. current_file
    io.popen(cmd)
end

function M.checkin_current_file()
    local cmd = ":!qtechng file ci " .. vim.fn.expand("%:p")
    vim.cmd(cmd)
end

function M.new_var(myvar)
    if myvar == nil then
        myvar = vim.fn.expand("<cword>")
    end
    local curpos = vim.fn.getcurpos()
    vim.cmd("?^ n ")
    local newpos = vim.fn.getcurpos()
    local newline = vim.fn.getline(".") .. "," .. myvar
    vim.api.nvim_buf_set_lines(0, newpos[2] - 1, newpos[2], false, { newline })
    vim.cmd("silent :noh")
    vim.fn.setpos(".", curpos)
end

function M.loop_vars()
    -- expand a line like this: RAdata(*nnr,*items,*types,*anr)
    local parts = _split(vim.fn.getline("."), "*")
    local lines = {}
    local loopvars = {}
    local var = ""
    for i, p in ipairs(parts) do
        if i == 1 then
            var = string.gsub(p, " ", "")
        else
            local indent = string.rep(".", i - 2)
            if indent ~= "" then indent = indent .. " " end
            local loopvar = p
            for _, char in ipairs({ ",", ")" }) do
                loopvar = _rstrip(loopvar, char)
            end
            table.insert(loopvars, loopvar)
            local line = " " .. indent .. "s " .. loopvar .. '=""'
            table.insert(lines, line)
            line = " " .. indent .. 'f  s ' .. loopvar .. "=$O("
            line = line .. var .. loopvar .. "))"
            line = line .. " q:" .. loopvar .. '=""  d'
            table.insert(lines, line)
            var = var .. loopvar .. ","
        end
    end
    -- replace line with loops
    local curpos = vim.fn.getcurpos()
    pos = curpos[2]
    vim.api.nvim_buf_set_lines(0, pos - 1, pos, false, lines)
    -- add loopvars to new instruction
    for _, loopvar in ipairs(loopvars) do
        M.new_var(loopvar)
    end
    -- go to end of inserted snippet
    curpos[2] = curpos[2] + #lines - 1
    vim.fn.setpos(".", curpos)
    vim.fn.feedkeys("A")
    vim.cmd("silent :noh")
end

function M.mumps_indent()
    local linepos = vim.fn.getcurpos()
    local posinline = linepos[3]
    local current_line = vim.fn.getline(".")
    local linelength = string.len(current_line)
    if posinline == linelength then
        -- cursor at end of the line
        local wordUnderCursor = vim.fn.expand("<cword>")
        local indent_level = _split(current_line, " ")
        local indent_begin = indent_level[2]
        local indent = ""
        if indent_begin ~= nil then
            if (wordUnderCursor == "d") or (wordUnderCursor == "q") then
                if wordUnderCursor == "d" then
                    if string.sub(indent_begin, 1, 1) == "." then
                        indent = " " .. indent_begin .. ". "
                    else
                        indent = " . "
                    end
                else
                    if string.sub(indent_begin, 1, 1) == "." then
                        local indent_minus_one = string.len(indent_begin) - 1
                        print(indent_minus_one)
                        if indent_minus_one < 1 then
                            indent = " "
                        else
                            indent = " " .. string.sub(indent_begin, 1, indent_minus_one) .. " "
                        end
                    else
                        indent = " "
                    end
                end
            else
                if string.sub(indent_begin, 1, 1) == "." then
                    indent = " " .. indent_begin .. " "
                else
                    indent = " "
                end
            end
        end
        local line = vim.fn.line(".")
        vim.fn.append(line, indent)
        local curpos = vim.fn.getcurpos()
        curpos[2] = curpos[2] + 1
        vim.fn.setpos(".", curpos)
        vim.fn.feedkeys("A")
    else
        -- cursor within the line
        vim.fn.feedkeys("a")
        vim.fn.feedkeys("\n")
    end
end

return M
