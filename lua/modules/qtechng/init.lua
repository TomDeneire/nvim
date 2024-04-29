---@diagnostic disable: undefined-global

--REGISTRY GLOBALS

OS_SEP = "$(qtechng registry get os-sep)"
WORK_DIR = "$(qtechng registry get qtechng-work-dir)"
SUPPORT_DIR = "$(qtechng registry get qtechng-support-dir)"
MACRO_DIR = "/home/tdeneire/Dropbox/brocade/support/macros"
BROBS = {}
for _, brob in ipairs({ "oaiset", "oai", "mprocess", "mailtrg", "usergroup", "ujson",
    "lookup", "history", "meta", "listattribute", "listidentity",
    "listdownloadtype", "cg", "loi", "search",
    "listsorttype", "nodeattribute", "listconversion" }) do
    BROBS[brob] = true
end

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

local function _rstrip(mystring, char)
    local length = string.len(mystring)
    local minus_one = string.sub(mystring, 1, length - 1)
    if minus_one .. char == mystring then
        return _rstrip(minus_one, char)
    else
        return mystring
    end
end

local function _lstrip(mystring, char)
    local length = string.len(mystring)
    local start = string.sub(mystring, 1, 1)
    if start == char then
        mystring = string.sub(mystring, 2, length)
        return _lstrip(mystring, char)
    else
        return mystring
    end
end

local function _file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

local function _lines_from_file(file)
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

function _capitalize(mystring)
    return string.upper(string.sub(mystring, 1, 1))
        .. string.sub(mystring, 2, #mystring)
end

function M.generate_lgcode()
    -- cg execty.catconkvs -> lgcode metaExecty.cgcatconkvs:
    -- cg mitem.catobject ->  lgcode metaMitem.cgcatobject.scope:
    -- $attribute: errorwrongcg -> lgcode metaCensor.errorwrongcg:
    -- $$content: identity -> lgcode metaCensor.titlemetaCensortypeIdentity:
    local current_line = vim.fn.getline(".")
    local brob = true
    local lgtype = ""
    local lgcode = ""
    local lgcodes = {}
    for _, ltype in ipairs({ "$attribute: ", "$$content: " }) do
        if string.find(current_line, ltype) then
            brob = false
            lgtype = ltype
        end
    end
    if brob == false then
        vim.cmd("?^meta ")
        local metaline = vim.fn.getline(".")
        local meta = _split(metaline, "meta ")
        local meta_type = _rstrip(meta[2], ":")
        meta_type = _capitalize(meta_type)
        local meta_name = _split(current_line, lgtype)[2]
        meta_name = _rstrip(meta_name, ":")
        if lgtype == "$$content: " then
            meta_name = "titlemeta" .. meta_type .. _capitalize(meta_name)
        end
        lgcode = "lgcode meta" .. meta_type
            .. "." .. meta_name
    else
        local words = _split(current_line, " ")
        local brob_type = words[1]
        local meta = _split(words[2], ".")
        local meta_type = meta[1]
        meta_type = _capitalize(meta_type)
        local meta_name = meta[2]
        meta_name = _rstrip(meta_name, ":")
        if BROBS[brob_type] then
            if brob_type == "cg" then
                lgcode = "lgcode meta" .. meta_type
                    .. "." .. brob_type .. meta_name
            end
        end
    end
    table.insert(lgcodes, lgcode .. ":")
    table.insert(lgcodes, "    N: «»")
    table.insert(lgcodes, lgcode .. ".scope:")
    table.insert(lgcodes, "    N: «»")
    local buf = vim.api.nvim_create_buf(false, true)
    local max_line_length = _get_max_line_length(lgcodes)
    local opts = {
        relative = "cursor",
        row = 1,
        col = 1,
        width = max_line_length,
        height = #lgcodes
    }
    vim.api.nvim_buf_set_lines(buf, 0, 1, false, lgcodes)
    vim.bo[buf].filetype = "lfile"
    vim.api.nvim_open_win(buf, 1, opts)
    vim.cmd("silent :noh")
end

function M.show_macro(macro)
    -- m4_getCensorType
    if macro == nil then
        macro = vim.fn.expand("<cword>")
        if string.find(macro, "m4_") == nil then
            return
        end
    end
    local buf = vim.api.nvim_create_buf(false, true)
    local content = _lines_from_file(MACRO_DIR .. "/" .. macro .. ".d")
    local max_line_length = _get_max_line_length(content)
    local opts = {
        relative = 'cursor',
        row = 1,
        col = 1,
        width = max_line_length,
        height = #content
    }
    vim.api.nvim_buf_set_lines(buf, 0, 1, false, content)
    vim.bo[buf].filetype = "dfile"
    vim.api.nvim_open_win(buf, 1, opts)
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

function _determine_paragraph(current_line)
    local index = current_line
    local begin_of_paragraph = 0
    local end_of_paragraph = 0
    while (true) do
        local previous = index - 1
        if previous == 0 then
            break
        end
        local line_up = vim.api.nvim_buf_get_lines(0, previous, index, false)[1]
        if line_up == "" or line_up == nil then
            break
        end
        index = index - 1
        begin_of_paragraph = index + 1
    end
    while (true) do
        local next = index + 1
        local line_down = vim.api.nvim_buf_get_lines(0, index, next, false)[1]
        if line_down == "" or line_down == nil then
            break
        end
        index = index + 1
        end_of_paragraph = index
    end
    return { begin_of_paragraph, end_of_paragraph }
end

function _get_variables_from_paragraph(lines)
    local variables = {}
    for _, line in ipairs(lines) do
        -- do not check new-line itself and do not check comments!
        if not line:match("^%sn%s") and (not line:match("^%s;")) then
            line = string.gsub(line, "%W+", " ")
            local vars = _split(line, " ")
            for _, var in ipairs(vars) do
                if var ~= "" then
                    variables[var] = true
                end
            end
        end
    end
    return variables
end

function _clean_newline(newline, variables)
    local newline = string.sub(newline, 4)
    local new_vars = _split(newline, ",")
    table.sort(new_vars)
    local clean_vars = ""
    local unique_vars = {}
    for _, var in ipairs(new_vars) do
        -- check if var is in paragraph
        if variables[var] ~= nil then
            -- check if var is unique
            if unique_vars[var] == nil then
                clean_vars = clean_vars .. "," .. var
                unique_vars[var] = true
            end
        end
    end
    clean_vars = _lstrip(clean_vars, ",")
    clean_newline = " n " .. clean_vars
    return clean_newline
end

function M.new_var(myvar)
    if myvar == nil then
        myvar = vim.fn.expand("<cword>")
    end
    myvar = _lstrip(myvar, "_")
    local curpos = vim.fn.getcurpos()
    vim.cmd("?^ n ")
    local newpos = vim.fn.getcurpos()
    local newline = vim.fn.getline(".") .. "," .. myvar
    local paragraph = _determine_paragraph(curpos[2])
    local lines = vim.api.nvim_buf_get_lines(0, paragraph[1], paragraph[2], false)
    local variables = _get_variables_from_paragraph(lines)
    newline = _clean_newline(newline, variables)
    vim.api.nvim_buf_set_lines(0, newpos[2] - 1, newpos[2], false, { newline })
    vim.cmd("silent :noh")
    vim.fn.setpos(".", curpos)
end

function M.loop_vars()
    -- expand a line like this: " RAdata(*nnr,*items,*types,*anr)"
    -- or: " ..... RAdata(*nnr,*items,*types,*anr)""
    local line = vim.fn.getline(".")
    -- construct loops
    local parts = _split(line, "*")
    local lines = {}
    local loopvars = {}
    local root_variable = ""
    local original_len = string.len(line)
    line = _lstrip(line, " ")
    line = _lstrip(line, ".")
    local stripped_len = string.len(line)
    local difference = original_len - stripped_len
    local startindent = " " .. string.rep(".", difference - 1)
    for i, p in ipairs(parts) do
        if i == 1 then
            root_variable = string.gsub(p, " ", "")
            local oldvar = root_variable
            root_variable = _lstrip(root_variable, ".")
        else
            local indent = string.rep(".", i - 2)
            local loopvar = p
            for _, char in ipairs({ ",", ")" }) do
                loopvar = _rstrip(loopvar, char)
            end
            table.insert(loopvars, loopvar)
            if i > 2 or difference > 1 then
                indent = indent .. " "
            end
            local setline = startindent .. indent .. "s " .. loopvar .. '=""'
            table.insert(lines, setline)
            local forline = startindent .. indent .. 'f  s ' .. loopvar .. "=$O("
            forline = forline .. root_variable .. loopvar .. "))"
            forline = forline .. " q:" .. loopvar .. '=""  d'
            table.insert(lines, forline)
            root_variable = root_variable .. loopvar .. ","
        end
    end
    -- replace line with loops
    local curpos = vim.fn.getcurpos()
    local pos = curpos[2]
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
