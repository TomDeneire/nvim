au BufRead,BufNewFile *.m                set filetype=mumps

autocmd FileType mumps setlocal expandtab shiftwidth=1 softtabstop=1

"functions
function! Indent()
    let wordUnderCursor = expand("<cword>")
    let current_line = getline(".")
    let indent_level = split(current_line," ")
    let indent_begin = indent_level[0]
    if (wordUnderCursor == "d") || (wordUnderCursor == "q")
        if (wordUnderCursor == "d")
            if matchstr(indent_begin, ".") == "."
                let indent = " " . indent_begin . ". "
            else
                let indent = " . "
            endif
        endif
        if (wordUnderCursor == "q")
            if indent_begin[0] == "."
                let indent_minus_one = len(indent_begin)-2
                if indent_minus_one == -1
                    let indent = " "
                else
                    let indent = " " . indent_begin[0:indent_minus_one] . " "
                endif
            else
                let indent = " "
            endif
        endif
    else
        let indent = " " . indent_begin . " "
    endif
    call append(line("."), indent)
    let curpos=getcurpos()
    let curpos[1] += 1
    call setpos(".", curpos)
    call feedkeys("A")
endfunction


function! Define()
    let g:wordUnderCursor = expand("<cword>")
    if (matchstr(g:wordUnderCursor, "m4_")) != ""
        :lua require("telescope.builtin").live_grep({hidden=true, cwd="/home/tdeneire/projects/brocade/source/data/", glob_pattern="*.d"})
    else
        :lua require("telescope.builtin").find_files({hidden=true, search_file=vim.api.nvim_get_var("wordUnderCursor")})
    endif
endfunction

autocmd FileType mumps inoremap <TAB> .
autocmd FileType mumps imap <CR> <ESC>:call Indent()<CR>
