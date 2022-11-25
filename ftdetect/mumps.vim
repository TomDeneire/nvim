au BufRead,BufNewFile *.m                set filetype=mumps

autocmd FileType mumps setlocal expandtab shiftwidth=1 softtabstop=1

"functions
function! Indent()
    echo "hallo"
    "let thisline = line(".")
	"let previousline = thisline - 1
	"echo getline(previousline)
    "let l:wordUnderCursor = expand("<cword>")
	"echo l:wordUnderCursor
	" if wordUnderCursor == "d"
	"     let current_line = getline(".")
	"     let indent_line = " ..."
	"     call append(line(".")-1, indent_line)
	"     let curpos=getcurpos()
	"     let curpos[1] -= 1
	"     "call setpos(".", curpos)
    " else
	"     call append(line(".")-1, " ")
	"     let curpos=getcurpos()
	"     let curpos[1] -= 1
	"     "call setpos(".", curpos)
    " endif
endfunction


function! Define()
    let g:wordUnderCursor = expand("<cword>")
    if (matchstr(g:wordUnderCursor, "m4_")) != ""
        :lua require("telescope.builtin").live_grep({hidden=true, cwd="/home/tdeneire/projects/brocade/source/data/", glob_pattern="*.d"})
    else
        :lua require("telescope.builtin").find_files({hidden=true, search_file=vim.api.nvim_get_var("wordUnderCursor")})
    endif
endfunction

"autocmd FileType mumps nnoremap <c-d> :call Define()<CR>
