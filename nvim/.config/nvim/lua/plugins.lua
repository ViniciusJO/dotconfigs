require('configs.lazy').bootstrap()

require('lazy').setup({
  { 'folke/which-key.nvim',   opts = {} }, -- Keymaps helper
  { 'tpope/vim-fugitive' },              -- Git integration
  { 'lewis6991/gitsigns.nvim' },         -- Git signalization
  { 'tpope/vim-sleuth' },
  {
    'nvim-neo-tree/neo-tree.nvim', -- File tree
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
  },
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true }, -- Adapters package manager
      'williamboman/mason-lspconfig.nvim',          -- LSP Mason integration
      { 'j-hui/fidget.nvim',       tag = 'legacy' }, -- Shows tasks progress
      'folke/neodev.nvim',                          -- Neovim completions and lsp
    },
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
  },
  {
    'hrsh7th/nvim-cmp',               -- Autocompletions
    dependencies = {
      'L3MON4D3/LuaSnip',             -- Snippets engine
      'saadparwaiz1/cmp_luasnip',     -- Snippets autocompletions
      'rafamadriz/friendly-snippets', -- Snippets
      'hrsh7th/cmp-nvim-lsp',         -- Lsp autocompletions
    },
  },

  -- Themes
  { 'wuelnerdotexe/vim-enfocado',         priority = 1000 },
  { 'catppuccin/nvim',                    name = 'catppuccin', priority = 1000 },
  { 'rebelot/kanagawa.nvim',              priority = 1000 },
  { 'nvim-lualine/lualine.nvim' },           -- Lualine e statusline
  { 'lukas-reineke/indent-blankline.nvim' }, -- Identation lines
  { 'numToStr/Comment.nvim',              opts = {} }, -- "gc" to comment visual regions/lines
  {
    'nvim-telescope/telescope.nvim',         -- Fuzzy finder
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate',
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },



  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',
}, {})
