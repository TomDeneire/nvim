au BufRead,BufNewFile *.m                set filetype=mumps

autocmd FileType mumps setlocal expandtab shiftwidth=1 softtabstop=1

"functions
function! Indent()
    echo filetype?
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
        if indent_begin[0] == "."
            let indent = " " . indent_begin . " "
        else
            let indent = " "
        endif
    endif
    call append(line("."), indent)
    let curpos=getcurpos()
    let curpos[1] += 1
    call setpos(".", curpos)
    call feedkeys("A")
endfunction


autocmd FileType mumps inoremap <buffer> <TAB> .
autocmd FileType mumps inoremap <buffer> <c-l> s nr=""<CR>f  s nr=$O(x,nr) q:nr=""  d<CR>
autocmd FileType mumps imap <buffer> <CR> <ESC>:call Indent()<CR>
