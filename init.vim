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
    Plug 'jose-elias-alvarez/null-ls.nvim'
    " Autocomplete plugs
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    " Syntax
    Plug 'preservim/vim-markdown'
    Plug 'vim-python/python-syntax'
    " Terminal
	Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
	" Bufferline
	Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
	" Colorschemes
	Plug 'ellisonleao/gruvbox.nvim'
    Plug 'martinsione/darkplus.nvim'
    Plug 'mhartington/oceanic-next'

    " Initialize plugin system
    " - Automatically executes `filetype plugin indent on` and `syntax enable`.
    call plug#end()
    " You can revert the settings after the call like so:
    "   filetype indent off   " Disable file-type-specific indentation
    "   syntax off            " Disable syntax highlighting

    "mappings (difficult in Lua)
    nnoremap <c-v> "*p
    inoremap <c-v> <Esc>"*pa
    vnoremap <c-c> "+y
    nnoremap <c-[> <c-^>

    "colorscheme
    syntax on
    let g:spunkshui_next_terminal_bold = 1
    let g:spunkshui_next_terminal_italic = 1
	let g:python_version_2 = 0
	let g:python_highlight_all = 1
    colorscheme spunkshui

    if (has("termguicolors"))
        set termguicolors
    endif

	"remove tildes
	highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

	"lua init
    lua require("init")

	"functions
	function FindInWorkSpace()
      let workspace = getcwd()
	  if (matchstr(workspace, "/brocade/source/data")) == ""
         :lua require("telescope.builtin").find_files({hidden=true, find_command={"rg","--smart-case","--files"}, no_ignore=true, no_ignore_parent=true, cwd="/home/tdeneire/projects/code"})
	  else
         :lua require("telescope.builtin").find_files({hidden=true, find_command={"rg","--smart-case","--files"}, no_ignore=true, no_ignore_parent=true, cwd="/home/tdeneire/projects/brocade/source/data"})
	  endif
	endfunction

	function GrepInWorkSpace()
      let workspace = getcwd()
	  if (matchstr(workspace, "/brocade/source/data")) == ""
         :lua require("telescope.builtin").live_grep({live_command={"rg","--smart-case","--files"}, no_ignore=true, no_ignore_parent=true, cwd="/home/tdeneire/projects/code"})
	  else
         :lua require("telescope.builtin").live_grep({live_command={"rg","--smart-case","--files"}, no_ignore=true, no_ignore_parent=true, cwd="/home/tdeneire/projects/brocade/source/data"})
	  endif
	endfunction

	function GrepPattern()
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

    function QtechNGComparePrevious()
        !export CURRENT_FILE=%:p && export QPATH=$(qtechng file tell $CURRENT_FILE --jsonpath='$..DATA..qpath' --unquote) && export PREVIOUS=$(qtechng registry get "qtechng-releases" | awk '{print $(NF-1)}') && mkdir -p $PREVIOUS && cd $PREVIOUS && qtechng source co $QPATH --version=$PREVIOUS && meld $PREVIOUS/$(qtechng file tell $CURRENT_FILE --jsonpath='$..DATA..relpath' --unquote) $CURRENT_FILE
    endfunction

    function QtechNGShowInGit()
        !export CURRENT_FILE=%:p && export URL=$(qtechng file tell $CURRENT_FILE --jsonpath='$..DATA..vcurl' --unquote) && google-chrome-stable $URL
    endfunction

    function DefineMacro()
        let g:macro_name = expand("<cword>")
        let g:macro_find = "echo $(qtechng registry get qtechng-work-dir)$(qtechng object list " . g:macro_name . " --jsonpath='$..DATA..source' --unquote)"
        let g:macro_file = system(g:macro_find)
        let g:macro_def = split(g:macro_name, "m4_")[0]
        let g:macro_open = "+/" . g:macro_def . " " . g:macro_file
        :execute 'tabnew' g:macro_open
    endfunction

    function JumpToRoutine()
        "d %CSV^ucsvsbld($file,$exec,$delimiter,$mode,$encoding,$fieldnames)»
        "«s $error=$$%ChckTyp^barsrou($type,$context,$user)»"
        let mrou = expand("<cWORD>")
        let g:mrou = split(mrou, "(")[0]
        :lua JumpToRou()
        let g:mfile = system(g:jumpexe)
        let g:mfile_open = "+/" . g:mlabel . " " . g:mfile
        :execute 'tabnew' g:mfile_open
    endfunction

    "qtechng mappings
    nnoremap <silent> <leader>qp :call QtechNGComparePrevious()<CR>
    nnoremap <silent> <leader>qg :call QtechNGShowInGit()<CR>
    nnoremap <leader>rou :call JumpToRoutine()<CR>
    nnoremap <c-m> :call DefineMacro()<CR>

    "mappings after lua init
    nnoremap <silent> <c-p> :call FindInWorkSpace()<CR>
	nnoremap <silent> <c-f> :call GrepInWorkSpace()<CR>
    nnoremap <silent> <leader>grep :call GrepPattern()<CR>

	"tabline
	:set showtabline=2

    " remove trailing whitespace
    autocmd BufWritePost *.vim lua Trim_trailing_whitespace()
    autocmd BufWritePost *.py lua Trim_trailing_whitespace()
    autocmd BufWritePost *.lua lua Trim_trailing_whitespace()
    autocmd BufWritePost *.go lua Trim_trailing_whitespace()
    autocmd BufWritePost *.js lua Trim_trailing_whitespace()
    autocmd BufWritePost *.x lua Trim_trailing_whitespace()

    "autoformat
    autocmd BufWritePost *.py lua vim.lsp.buf.format()
    autocmd BufWritePost *.go lua vim.lsp.buf.format()
    autocmd BufWritePost *.go lua vim.lsp.buf.code_action()
    autocmd BufWritePost *.js lua vim.lsp.buf.format()
    autocmd BufWritePost *.js lua vim.lsp.buf.code_action()
    autocmd BufWritePost *.lua lua vim.lsp.buf.format()
    autocmd BufWritePost *.html lua vim.lsp.buf.format()
    autocmd BufWritePost *.xml lua vim.lsp.buf.format()
    autocmd BufWritePost *.json lua vim.lsp.buf.format()
    autocmd BufWritePost *.m :silent !qtechng file format --inplace %:p
    autocmd BufWritePost *.d :silent !qtechng file format --inplace %:p
    autocmd BufWritePost *.i :silent !qtechng file format --inplace %:p
    autocmd BufWritePost *.b :silent !qtechng file format --inplace %:p
    autocmd BufWritePost *.l :silent !qtechng file format --inplace %:p

    " search options
    :set nohlsearch
    :set ignorecase

    "line numbers
    :set number
    :set relativenumber

    " change cwd automatically
    :set autochdir

    " markdown settings
    :set nofoldenable
    :set conceallevel=0

	" default tabstop
	:set expandtab
	:set shiftwidth=4
	:set tabstop=4

	" commenting
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

endif
