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
        line_len = line_len + ((#tabs - 1) * 4)
        if line_len > max_len then max_len = line_len end
    end
    return max_len
end

local function _capitalize(mystring)
    return string.upper(string.sub(mystring, 1, 1))
        .. string.sub(mystring, 2, #mystring)
end

local function _notify(msg)
    vim.notify("QtechNG: " .. msg, vim.log.levels.WARN)
end

local function _is_label_line(line)
    return line:match("^sub%s") ~= nil or line:match("^def%s") ~= nil or line:match("^fn%s") ~= nil
end

local function _function_bounds(lnum)
    -- Label line and last line of the sub/fn/def that contains lnum (1-based)
    local first = lnum
    while first >= 1 and not _is_label_line(vim.fn.getline(first)) do
        first = first - 1
    end
    if first < 1 then
        return nil
    end
    local last = vim.fn.line("$")
    for l = first + 1, last do
        if _is_label_line(vim.fn.getline(l)) then
            last = l - 1
            break
        end
    end
    return first, last
end

local function _goto_label(label)
    -- Put the cursor on the sub/fn/def line that defines label in the current buffer
    vim.fn.cursor(1, 1)
    local pattern = [[^\%(sub\|def\|fn\) \V]] .. vim.fn.escape(label, [[\]]) .. [=[\m[(:]]=]
    if vim.fn.search(pattern, "cW") == 0 then
        _notify("label " .. label .. " not found")
    end
end

local function _keyword_under_cursor()
    -- Word under the cursor, without "_" (the MUMPS concatenation operator)
    local saved = vim.bo.iskeyword
    vim.opt_local.iskeyword:remove("_")
    local word = vim.fn.expand("<cword>")
    vim.bo.iskeyword = saved
    return word
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
        local meta_lnum = vim.fn.search("^meta ", "bnW")
        if meta_lnum == 0 then
            _notify("no meta line found above the cursor")
            return
        end
        local metaline = vim.fn.getline(meta_lnum)
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
        local meta = _split(words[2] or "", ".")
        if BROBS[brob_type] and meta[2] ~= nil then
            local meta_type = meta[1]
            meta_type = _capitalize(meta_type)
            local meta_name = meta[2]
            meta_name = _rstrip(meta_name, ":")
            if brob_type == "cg" then
                lgcode = "lgcode meta" .. meta_type
                    .. "." .. brob_type .. meta_name
            end
        end
    end
    if lgcode == "" then
        _notify("no lgcode for this line")
        return
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
end

function M.show_macro(macro)
    -- m4_getCensorType
    if macro == nil then
        macro = vim.fn.expand("<cword>")
        if string.find(macro, "m4_") == nil then
            return
        end
    end
    local macro_file = MACRO_DIR .. "/" .. macro .. ".d"
    local content = _lines_from_file(macro_file)
    if #content == 0 then
        _notify("macro file not found: " .. macro_file)
        return
    end
    local buf = vim.api.nvim_create_buf(false, true)
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
    mroutine = _rstrip(mroutine, "]")
    local m = _split(mroutine, "(")
    mroutine = m[1]
    local t = _split(mroutine, "^")
    local mlabel = t[1]
    local l = _split(mlabel, "$$")
    if l[2] ~= nil then
        mlabel = l[2]
    end
    if t[2] == nil then
        -- Label without routine: it lives in the current file
        _goto_label(mlabel)
        return
    end
    local mfile = t[2] .. ".m"
    local jumpcmd = "echo "
    jumpcmd = jumpcmd .. WORK_DIR
    jumpcmd = jumpcmd .. OS_SEP
    jumpcmd = jumpcmd .. "$(jq -r '." .. '"' .. mfile .. '"' .. "' "
    jumpcmd = jumpcmd .. SUPPORT_DIR .. OS_SEP .. "m_unique_map.json)"
    jumpcmd = jumpcmd .. OS_SEP .. mfile
    local resultfile = vim.trim(vim.fn.system(jumpcmd))
    -- jq prints "null" for a routine that is not in the map
    if resultfile:match("[/\\]null[/\\][^/\\]*$") then
        _notify("routine " .. t[2] .. " not found")
        return
    end
    vim.cmd.edit(vim.fn.fnameescape(resultfile))
    _goto_label(mlabel)
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
    if pattern == "" then
        return
    end
    local listcmd = "qtechng source list --smartcase --jsonpath=$..DATA..fileurl --needle=" ..
        vim.fn.shellescape(pattern) .. " | awk -F 'file://' '{print $2}' | awk -F '\"' '{print $1}'"
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
            scroll_strategy = "limit",
            cwd = "/home/tdeneire/Dropbox/brocade/support/macros"
        })
end

function M.open_in_git_browser()
    local current_file = vim.fn.expand("%:p")
    local gitcmd = "sensible-browser $(qtechng file tell " .. current_file
    gitcmd = gitcmd .. " --jsonpath='$..DATA..vcurl' --unquote)"
    vim.fn.jobstart({ "sh", "-c", gitcmd }, { detach = true })
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
    vim.fn.jobstart({ "sh", "-c", cmd }, { detach = true })
end

function M.checkin_current_file()
    -- Write unsaved changes first, so they are part of the check-in
    vim.cmd("silent update")
    local cmd = ":!qtechng file ci " .. vim.fn.expand("%:p")
    vim.cmd(cmd)
end

local function _get_variables(lines)
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

local function _clean_newline(newline, myvar, variables)
    -- Arguments end at the first space; keep what follows (e.g. a comment)
    local args, rest = string.sub(newline, 4):match("^(%S*)(.*)$")
    local new_vars = _split(args, ",")
    table.insert(new_vars, myvar)
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
    -- " n " without arguments would NEW all variables
    if clean_vars == "" then
        return nil
    end
    return " n " .. clean_vars .. rest
end

function M.new_var(myvar)
    if myvar == nil then
        myvar = _keyword_under_cursor()
    end
    myvar = _lstrip(myvar, "_")
    local curpos = vim.fn.getcurpos()
    local first, last = _function_bounds(curpos[2])
    if first == nil then
        _notify("no sub/fn/def label above the cursor")
        return
    end
    -- Body of the function, without its label line
    local lines = vim.api.nvim_buf_get_lines(0, first, last, false)
    local variables = _get_variables(lines)
    local new_lnum = nil
    for i, line in ipairs(lines) do
        if line:match("^ n ") then
            new_lnum = first + i
            break
        end
    end
    if new_lnum == nil then
        if variables[myvar] == nil then
            return
        end
        -- Function has no new line yet: add one under the label
        vim.api.nvim_buf_set_lines(0, first, first, false, { " n " .. myvar })
        if curpos[2] > first then
            curpos[2] = curpos[2] + 1
        end
    else
        local newline = _clean_newline(vim.fn.getline(new_lnum), myvar, variables)
        if newline ~= nil then
            vim.api.nvim_buf_set_lines(0, new_lnum - 1, new_lnum, false, { newline })
        end
    end
    vim.fn.setpos(".", curpos)
end

function M.loop_vars()
    -- expand a line like this: " RAdata(*nnr,*items,*types,*anr)"
    -- or: " ..... RAdata(*nnr,*items,*types,*anr)""
    local line = vim.fn.getline(".")
    if string.find(line, "*", 1, true) == nil then
        _notify("no *loop variables on this line")
        return
    end
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
    -- go to end of inserted snippet (new_var keeps the cursor on it)
    curpos[2] = curpos[2] + #lines - 1
    vim.fn.setpos(".", curpos)
    -- add loopvars to new instruction
    for _, loopvar in ipairs(loopvars) do
        M.new_var(loopvar)
    end
    vim.fn.feedkeys("A")
    vim.cmd("silent :noh")
end

function M.mumps_indent()
    -- Called from insert mode via <Cmd>, so the cursor column is the insert position
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local current_line = vim.api.nvim_get_current_line()
    local linelength = string.len(current_line)
    if col == linelength then
        -- cursor at end of the line
        local wordUnderCursor = current_line:match("(%w+)$")
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
        vim.api.nvim_buf_set_lines(0, row, row, false, { indent })
        vim.api.nvim_win_set_cursor(0, { row + 1, string.len(indent) })
    elseif col == 0 then
        -- cursor at start of the line: open a line above, keeping the leading space of this one
        vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { "" })
        vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
    else
        -- cursor within the line
        vim.api.nvim_feedkeys(vim.keycode("<CR>"), "ni", false)
    end
end

return M
