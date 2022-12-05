if exists('g:vscode')
    " VSCode extension
    :set ignorecase
    :set nohlsearch
else
    " Neovim
    "
    "Plugins
    call plug#begin(stdpath('data') . '/plugged')
    " The default plugin directory will be as follows:
    "   - Vim (Linux/macOS): '~/.vim/plugged'
    "   - Vim (Windows): '~/vimfiles/plugged'
    "   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
    " You can specify a custom plugin directory by passing it as the argument
    "   - e.g. `call plug#begin('~/.vim/plugged')`
    "   - Avoid using standard Vim directory names like 'plugin'
    " Make sure you use single quotes

	" Various
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'ThePrimeagen/vim-be-good'
    Plug 'godlygeek/tabular'
    " Tree
    Plug 'nvim-tree/nvim-tree.lua'
    " Lualine
    Plug 'nvim-lualine/lualine.nvim'
    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'p00f/nvim-ts-rainbow'
    " Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    " Devicons 
    Plug 'kyazdani42/nvim-web-devicons'
	" Easy (un)commenting
    Plug 'preservim/nerdcommenter'
    " Undotree
    Plug 'mbbill/undotree'
	" Git
	Plug 'airblade/vim-gitgutter'
    " Mason
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
	" Lsp
    Plug 'neovim/nvim-lspconfig'
    Plug 'kabouzeid/nvim-lspinstall'
    Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
    Plug 'onsails/lspkind.nvim'
    Plug 'ray-x/lsp_signature.nvim'
  "let s:brown  = ['#ab7967', '137']
    " Syntax
    Plug 'preservim/vim-markdown'
    Plug 'vim-python/python-syntax'
    " Autocomplete plugs
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
	" Terminal
	Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
	" Bufferline
	Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
	" Colorschemes
	Plug 'ellisonleao/gruvbox.nvim'
    Plug 'tanvirtin/monokai.nvim'
    Plug 'martinsione/darkplus.nvim'
    Plug 'arcticicestudio/nord-vim'
    Plug 'mhartington/oceanic-next'
    Plug 'joshdick/onedark.vim'
    Plug 'bluz71/vim-moonfly-colors'
    Plug 'navarasu/onedark.nvim'

    " Initialize plugin system
    " - Automatically executes `filetype plugin indent on` and `syntax enable`.
    call plug#end()
    " You can revert the settings after the call like so:
    "   filetype indent off   " Disable file-type-specific indentation
    "   syntax off            " Disable syntax highlighting

    "basic mappings
    imap jj <Esc>
    nmap <c-a> ggVG
    nmap <silent> <c-i> :lua vim.lsp.buf.hover()<CR>
    nmap <silent> <c-s> :w<CR>
    imap <silent> <c-s> <Esc> :w<CR>
    nmap <c-v> "*p
    imap <c-v> <Esc>"*pa
    vmap <c-c> "+y
	nmap <c-j> 10j
	nmap <c-k> 10k
	vmap <c-j> 10j
	vmap <c-k> 10k
    nnoremap <F5> :UndotreeToggle<CR>
	
	
    "colorscheme
    syntax on
    let g:spunkshui_next_terminal_bold = 1
    let g:spunkshui_next_terminal_italic = 1
	let g:python_version_2 = 0
	let g:python_highlight_all = 1
    colorscheme spunkshui
    "colorscheme dark+

    if (has("termguicolors"))
        set termguicolors
    endif

	"remove tildes
	highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg


	"lua init
    lua require("init")

	"functions
	function! FindInWorkSpace()
      let workspace = getcwd()
	  if (matchstr(workspace, "/brocade/source/data")) == ""
         :lua require("telescope.builtin").find_files({hidden=true, find_command={"rg","--smart-case","--files"}, no_ignore=true, no_ignore_parent=true, cwd="/home/tdeneire/projects/code"})
	  else
         :lua require("telescope.builtin").find_files({hidden=true, find_command={"rg","--smart-case","--files"}, no_ignore=true, no_ignore_parent=true, cwd="/home/tdeneire/projects/brocade/source/data"})
	  endif
	endfunction

	function! GrepInWorkSpace()
      let workspace = getcwd()
	  if (matchstr(workspace, "/brocade/source/data")) == ""
         :lua require("telescope.builtin").live_grep({live_command={"rg","--smart-case","--files"}, no_ignore=true, no_ignore_parent=true, cwd="/home/tdeneire/projects/code"})
	  else
         :lua require("telescope.builtin").live_grep({live_command={"rg","--smart-case","--files"}, no_ignore=true, no_ignore_parent=true, cwd="/home/tdeneire/projects/brocade/source/data"})
	  endif
	endfunction

	function! GrepPattern()
      let workspace = getcwd()
      let pattern = input("Grep_pattern=", "*.")
	  if (matchstr(workspace, "/brocade/source/data")) == ""
         let g:greppattern = pattern
         :lua require("telescope.builtin").live_grep({live_command={"rg","--smart-case","--files"}, no_ignore=true, no_ignore_parent=true, cwd="/home/tdeneire/projects/code", glob_pattern=vim.g.greppattern})
	  else
         let g:greppattern = pattern
         :lua require("telescope.builtin").live_grep({live_command={"rg","--smart-case","--files"}, no_ignore=true, no_ignore_parent=true, cwd="/home/tdeneire/projects/brocade/source/data", glob_pattern=vim.g.greppattern})
	  endif
	endfunction

    function! QtechNGComparePrevious()
        !export CURRENT_FILE=%:p && export QPATH=$(qtechng file tell $CURRENT_FILE --jsonpath='$..DATA..qpath' --unquote) && export PREVIOUS=$(qtechng registry get "qtechng-releases" | awk '{print $(NF-1)}') && mkdir -p $PREVIOUS && cd $PREVIOUS && qtechng source co $QPATH --version=$PREVIOUS && meld $PREVIOUS/$(qtechng file tell $CURRENT_FILE --jsonpath='$..DATA..relpath' --unquote) $CURRENT_FILE
    endfunction

    function! QtechNGShowInGit()
        !export CURRENT_FILE=%:p && export URL=$(qtechng file tell $CURRENT_FILE --jsonpath='$..DATA..vcurl' --unquote) && google-chrome-stable $URL
    endfunction

    function! DefineMacro()
        " function to lookup m4_isLOI
        let g:macro_name = expand("<cword>")
        let g:macro_find = "echo $(qtechng registry get qtechng-work-dir)$(qtechng object list " . g:macro_name . " --jsonpath='$..DATA..source' --unquote)"
        let g:macro_file = system(g:macro_find)
        let g:macro_def = split(g:macro_name, "m4_")[0]
        let g:macro_open = "+/" . g:macro_def . " " . g:macro_file
        :execute 'tabnew' g:macro_open
    endfunction

    "qtechng mappings
    nmap <silent> <leader>qp :call QtechNGComparePrevious()<CR>
    nmap <silent> <leader>qg :call QtechNGShowInGit()<CR>
	nmap <c-b> :!qtechng file ci %:p<CR>
	nmap <c-o> :!qtechng file refresh<CR>
    nmap <c-m> :call DefineMacro()<CR>

    "mappings after lua init
    nmap <silent> <c-p> :call FindInWorkSpace()<CR>
	nmap <silent> <c-f> :call GrepInWorkSpace()<CR>
	nmap <silent> <c-D> <cmd>lua vim.lsp.buf.definition()<CR>
    nmap <silent> <leader>term :ToggleTerm dir=getcwd()<CR>
    nmap <silent> <leader>grep :call GrepPattern()<CR>
    nmap <silent> <leader>old :Telescope oldfiles<CR>
    nmap <silent> <leader>def :Lspsaga peek_definition<CR>
    nmap <silent> <leader>rn :Lspsaga rename<CR>

	"tabline
	:set showtabline=2
    nmap <silent> tn :tabnew<CR>
    " nmap <silent> tn :tabnew<CR>:NvimTreeToggle<CR>:NvimTreeRefresh<CR>
    nmap <silent> tl :+tabnext<CR>
    nmap <silent> th :-tabnext<CR>
    nmap <silent> tt :NvimTreeToggle<CR>

	" function MyTabLine()
	"   let s = ''
	"   for i in range(tabpagenr('$'))
	"     " select the highlighting
	"     if i + 1 == tabpagenr()
	"       let s ..= '%#TabLineSel#'
	"     else
	"       let s ..= '%#TabLine#'
	"     endif
    "
	"     " set the tab page number (for mouse clicks)
	"     let s ..= '%' .. (i + 1) .. 'T'
    "
	"     " the label is made by MyTabLabel()
	"     let s ..= ' %{MyTabLabel(' .. (i + 1) .. ')} '
	"   endfor
    "
	"   " after the last tab fill with TabLineFill and reset tab page nr
	"   let s ..= '%#TabLineFill#%T'
    "
	"   " right-align the label to close the current tab page
	"   if tabpagenr('$') > 1
	"     let s ..= '%=%#TabLine#%999Xclose'
	"   endif
    "
	"   return s
	" endfunction
    "
	" function MyTabLabel(n)
	"   let buflist = tabpagebuflist(a:n)
	"   let winnr = tabpagewinnr(a:n)
	"   return bufname(buflist[winnr - 1])
	" endfunction

	":set tabline=%!MyTabLine()

	
	"autohover
	" :set updatetime=1000
    " autocmd CursorHold *.py lua vim.lsp.buf.hover()
    " autocmd CursorHold *.go lua vim.lsp.buf.hover()
    " autocmd CursorHold *.js lua vim.lsp.buf.hover()

    "autoformat
    autocmd BufWritePost *.py lua vim.lsp.buf.format()
    autocmd BufWritePost *.go lua vim.lsp.buf.format()
    autocmd BufWritePost *.js lua vim.lsp.buf.format()
    autocmd BufWritePost *.m :silent !qtechng file format --inplace %:p
    autocmd BufWritePost *.d :silent !qtechng file format --inplace %:p
    autocmd BufWritePost *.i :silent !qtechng file format --inplace %:p
    autocmd BufWritePost *.b :silent !qtechng file format --inplace %:p
    autocmd BufWritePost *.l :silent !qtechng file format --inplace %:p

    " search options
    :set nohlsearch
    :set ignorecase

"    hi Normal guibg=NONE ctermbg=NONE
"    hi LineNr guibg=NONE ctermbg=NONE
"    hi SignColumn guibg=NONE ctermbg=NONE
"    hi EndOfBuffer guibg=NONE ctermbg=NONE

    "line numbers
    :set number
    :set relativenumber

    " change cwd automatically
    :set autochdir

    " markdown settings
    :set nofoldenable
    :set conceallevel=0

	"tabstop
	:set expandtab
	:set shiftwidth=4
	:set tabstop=4

	" Commenting
	filetype plugin on
    " Create default mappings
    let g:NERDCreateDefaultMappings = 1
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1
    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'
    " Set a language to use its alternate delimiters by default
    let g:NERDAltDelims_java = 1
    " Add your own custom formats or override the defaults
    let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1
    " Enable NERDCommenterToggle to check all selected lines is commented or not 
    let g:NERDToggleCheckAllLines = 1
    vmap <silent> cc :call nerdcommenter#Comment('x', 'toggle')<CR>

endif
