if exists('g:vscode')
    " VSCode extension
    "
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
    Plug 'nvim-telescope/telescope-file-browser.nvim'
    " Devicons
    Plug 'kyazdani42/nvim-web-devicons'
	" Easy (un)commenting
    Plug 'preservim/nerdcommenter'
    " Undotree
    Plug 'mbbill/undotree'
	" Git
	Plug 'airblade/vim-gitgutter'
    Plug 'kdheepak/lazygit.nvim'
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
    " Snippets
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'rafamadriz/friendly-snippets'
    " Syntax
    Plug 'preservim/vim-markdown'
    Plug 'vim-python/python-syntax'
    " Terminal
	Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
	" Bufferline
	Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
	" Colorschemes
    Plug 'martinsione/darkplus.nvim'
    Plug 'mhartington/oceanic-next'
    " Whichkey
    Plug 'folke/which-key.nvim'
    " Center screen
    Plug 'shortcuts/no-neck-pain.nvim', { 'tag': '*' }

    " Initialize plugin system
    " - Automatically executes `filetype plugin indent on` and `syntax enable`.
    call plug#end()
    " You can revert the settings after the call like so:
    "   filetype indent off   " Disable file-type-specific indentation
    "   syntax off            " Disable syntax highlighting

    "mappings (different result in Lua)
    nnoremap <c-[> <c-^>
    vmap <silent> cc :call nerdcommenter#Comment('x', 'toggle')<CR>

	"lua init
    lua require("init")

	"commenting
	filetype plugin on

endif
