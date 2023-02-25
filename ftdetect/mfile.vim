au BufRead,BufNewFile *.m                set filetype=mfile

augroup WrapMFile
    autocmd!
    autocmd FileType mfile setlocal wrap
augroup END
